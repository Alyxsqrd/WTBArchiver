package designs

import (
	"database/sql"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"net/http"
	"os"
	"path/filepath"
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
	DesignData  designData
	OnSale      int
}

type creatorData struct {
	UserID int
}

type designData struct {
	Name                string
	Sales               int `json:",string"`
	Description         *string
	FullDate_LastUpdate string
}

type responseData2 struct {
	Data string
}

var location, _ = time.LoadLocation("America/New_York")

func fetchInfo(id string, client http.Client) (data *responseData1, err error) {
	res, err := client.Get("https://www.worldtobuild.com/api/designs/fetch-design-data?designId=" + id)

	if err != nil {
		return nil, err
	}

	defer res.Body.Close()

	if res.StatusCode != 200 {
		return nil, errors.New("invalid info status: " + strconv.Itoa(res.StatusCode))
	}

	err = json.NewDecoder(res.Body).Decode(&data)

	if err != nil {
		return nil, err
	} else if data.Data.CreatorData.UserID == 0 {
		return nil, fmt.Errorf("invalid info json: %+v", data)
	}

	data.Data.DesignData.Name = utils.SanitizeString(data.Data.DesignData.Name)

	if data.Data.DesignData.Description != nil {
		description := utils.SanitizeString(*data.Data.DesignData.Description)

		if len(description) == 0 {
			data.Data.DesignData.Description = nil
		} else {
			data.Data.DesignData.Description = &description
		}
	}

	timestamp, err := time.ParseInLocation("January 02, 2006 3:04pm", data.Data.DesignData.FullDate_LastUpdate, location)

	if err != nil {
		return nil, err
	}

	data.Data.DesignData.FullDate_LastUpdate = strconv.FormatInt(timestamp.Unix(), 10)

	return
}

func downloadData(id string, pwd string, client http.Client) error {
	res, err := client.Get("https://www.worldtobuild.com/api/bundles/fetch-design-data?designId=" + id)

	if err != nil {
		return err
	}

	defer res.Body.Close()

	if res.StatusCode != 200 {
		return errors.New("invalid data status: " + strconv.Itoa(res.StatusCode))
	}

	var data responseData2
	err = json.NewDecoder(res.Body).Decode(&data)

	if err != nil {
		return err
	} else if data.Data == "" {
		return fmt.Errorf("invalid data json: %+v", data)
	}

	err = os.WriteFile(filepath.Join(pwd, id+".wtbr"), []byte(data.Data), 0664)

	return err
}

func downloadThumbnail(id string, pwd string, client http.Client) error {
	res, err := client.Get("https://lake.worldtobuild.com/community/designs/" + id)

	if err != nil {
		return err
	}

	defer res.Body.Close()

	if res.StatusCode != 200 {
		return errors.New("invalid lake status: " + strconv.Itoa(res.StatusCode))
	}

	doc := html.NewTokenizer(res.Body)

	for {
		if doc.Next() == html.ErrorToken {
			err = doc.Err()

			if err == io.EOF {
				err = nil
				break
			}

			return err
		}

		tag, hasAttr := doc.TagName()

		if !hasAttr || string(tag) != "img" {
			continue
		}

		attr, value, _ := doc.TagAttr()

		if string(attr) != "class" || string(value) != "jsr2d" {
			continue
		}

		attr, value, _ = doc.TagAttr()

		if string(attr) != "src" {
			continue
		}

		src := string(value)

		if !strings.HasPrefix(src, "https://cdn.worldtobuild.com/design-snapshots/") {
			continue
		}

		res, err = client.Get(src)

		if err != nil {
			return err
		}

		defer res.Body.Close()

		if res.StatusCode != 200 {
			return errors.New("invalid thumbnail status: " + strconv.Itoa(res.StatusCode))
		}

		file, err := os.Create(filepath.Join(pwd, id+".png"))

		if err != nil {
			return err
		}

		defer file.Close()
		_, err = io.Copy(file, res.Body)

		return err
	}

	return errors.New("missing CDN thumbnail")
}

func Archive(max int, pwd string, client http.Client, db *sql.DB) error {
	designsPath := filepath.Join(pwd, "..", "assets", "designs")
	err := os.RemoveAll(designsPath)

	if err != nil {
		return err
	}

	err = os.MkdirAll(designsPath, 0664)

	if err != nil {
		return err
	}

	thumbnailsPath := filepath.Join(pwd, "..", "assets", "thumbnails", "designs")
	err = os.RemoveAll(thumbnailsPath)

	if err != nil {
		return err
	}

	err = os.MkdirAll(thumbnailsPath, 0664)

	if err != nil {
		return err
	}

	_, err = db.Exec("DELETE FROM designs")

	if err != nil {
		return err
	}

	for i := 1; i <= max; i++ {
		id := strconv.Itoa(i)

		data, err := fetchInfo(id, client)

		if err != nil {
			fmt.Println("\033[91m[SKIP] Design #" + id + " Info: " + err.Error())
			continue
		}

		err = downloadData(id, designsPath, client)

		if err != nil {
			fmt.Println("\033[91m[SKIP] Design #" + id + " Data: " + err.Error())
			continue
		}

		err = downloadThumbnail(id, thumbnailsPath, client)

		if err != nil {
			fmt.Println("\033[91m[SKIP] Design #" + id + " Thumbnail: " + err.Error())
			continue
		}

		_, err = db.Exec(
			"REPLACE INTO designs (id, name, description, is_public, sales, creator_id, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?)",
			i, data.Data.DesignData.Name, data.Data.DesignData.Description, data.Data.OnSale, data.Data.DesignData.Sales, data.Data.CreatorData.UserID, data.Data.DesignData.FullDate_LastUpdate,
		)

		if err != nil {
			fmt.Println("\033[91m[SKIP] Design #" + id + " Database: " + err.Error())
			continue
		}

		fmt.Println("\033[92m[DONE] Design #" + id + " successfully archived!")
	}

	return nil
}
