package products

import (
	"database/sql"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"math"
	"net/http"
	"scraper/utils"
	"strconv"
	"strings"
	"time"

	_ "github.com/mattn/go-sqlite3"
	"golang.org/x/net/html"
)

type responseData1 struct {
	Data responseData1Ext
}

type responseData1Ext struct {
	CreatorData creatorData
	ProductData productData
}

type creatorData struct {
	UserID int
}

type productData struct {
	Name                string
	Sales               int `json:",string"`
	Description         *string
	BuildBux            int `json:",string"`
	Qbits               int `json:",string"`
	FullDate_LastUpdate string
}

type responseData2 struct {
	Data responseData2Ext
}

type responseData2Ext struct {
	Type               string
	CollectibleOptions collectibleOptions
}

type collectibleOptions struct {
	InitialStock int
}

type responseData3 struct {
	DesignID *int
}

var location, _ = time.LoadLocation("America/New_York")

var typeIDs = map[string]int{
	"Hat":  1,
	"Head": 2,
	"Body": 3,
	"Arm":  4,
	"Leg":  5,
	"Pet":  6,
	"Cape": 7,
	"Set":  8,
}

func fetchInfo(id string, client http.Client) (data *responseData1, data2 *responseData2, data3 *responseData3, err error) {
	res, err := client.Get("https://www.worldtobuild.com/api/shop/fetch-product-data?productId=" + id)

	if err != nil {
		return nil, nil, nil, err
	}

	defer res.Body.Close()

	if res.StatusCode != 200 {
		return nil, nil, nil, errors.New("invalid info status: " + strconv.Itoa(res.StatusCode))
	}

	err = json.NewDecoder(res.Body).Decode(&data)

	if err != nil {
		return nil, nil, nil, err
	} else if data.Data.CreatorData.UserID == 0 {
		return nil, nil, nil, fmt.Errorf("invalid info json: %+v", data)
	}

	data.Data.ProductData.Name = utils.SanitizeString(data.Data.ProductData.Name)

	if data.Data.ProductData.Description != nil {
		description := utils.SanitizeString(*data.Data.ProductData.Description)

		if len(description) == 0 {
			data.Data.ProductData.Description = nil
		} else {
			data.Data.ProductData.Description = &description
		}
	}

	timestamp, err := time.ParseInLocation("January 02, 2006 3:04pm", data.Data.ProductData.FullDate_LastUpdate, location)

	if err != nil {
		return nil, nil, nil, err
	}

	data.Data.ProductData.FullDate_LastUpdate = strconv.FormatInt(timestamp.Unix(), 10)

	res, err = client.Get("https://www.worldtobuild.com/api/shop/fetch-product-tags?productId=" + id)

	if err != nil {
		return nil, nil, nil, err
	}

	defer res.Body.Close()

	if res.StatusCode != 200 {
		return nil, nil, nil, errors.New("invalid tags status: " + strconv.Itoa(res.StatusCode))
	}

	err = json.NewDecoder(res.Body).Decode(&data2)

	if err != nil {
		return nil, nil, nil, err
	} else if data2.Data.Type == "" {
		return nil, nil, nil, fmt.Errorf("invalid tags json: %+v", data2)
	}

	slug := data2.Data.Type

	if slug == "Hat" || slug == "Pet" || slug == "Cape" || slug == "Set" {
		slug = strings.ToLower(slug)
	} else {
		slug = "body-part"
	}

	res, err = client.Get("https://lake.worldtobuild.com/marketplace/" + slug + "/" + id)

	if err != nil {
		return nil, nil, nil, err
	}

	defer res.Body.Close()

	if res.StatusCode != 200 {
		return nil, nil, nil, errors.New("invalid lake status: " + strconv.Itoa(res.StatusCode))
	}

	doc := html.NewTokenizer(res.Body)
	data3 = new(responseData3)

	for {
		if doc.Next() == html.ErrorToken {
			err = doc.Err()

			if err == io.EOF {
				err = nil
				break
			}

			return nil, nil, nil, err
		}

		tag, hasAttr := doc.TagName()

		if !hasAttr || string(tag) != "div" {
			continue
		}

		attr, value, _ := doc.TagAttr()

		if string(attr) != "class" || !strings.HasPrefix(string(value), "jsr jsr3d") {
			continue
		}

		attr, value, _ = doc.TagAttr()

		if string(attr) != "design" {
			continue
		}

		id2, err := strconv.Atoi(string(value))

		if err != nil {
			return nil, nil, nil, err
		}

		data3.DesignID = &id2
	}

	return
}

func Archive(max int, pwd string, client http.Client, db *sql.DB) error {
	_, err := db.Exec("DELETE FROM products")

	if err != nil {
		return err
	}

	for i := 1; i <= max; i++ {
		i = 1745
		id := strconv.Itoa(i)

		data, data2, data3, err := fetchInfo(id, client)

		if err != nil {
			fmt.Println("\033[91m[SKIP] Product #" + id + " Info: " + err.Error())
			continue
		}

		_, err = db.Exec(
			"REPLACE INTO products (id, type_id, name, description, buildbux, qbits, is_offsale, sales, stock, design_id, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
			i, typeIDs[data2.Data.Type], data.Data.ProductData.Name, data.Data.ProductData.Description, data.Data.ProductData.BuildBux, data.Data.ProductData.Qbits, false, data.Data.ProductData.Sales, math.Max(float64(data2.Data.CollectibleOptions.InitialStock), 0), data3.DesignID, data.Data.ProductData.FullDate_LastUpdate,
		)

		if err != nil {
			fmt.Println("\033[91m[SKIP] Product #" + id + " Database: " + err.Error())
			continue
		}

		fmt.Println("\033[92m[DONE] Product #" + id + " successfully archived!")
	}

	return nil
}
