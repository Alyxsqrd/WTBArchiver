package sets

import (
	"database/sql"
	"encoding/json"
	"errors"
	"fmt"
	"net/http"
	"strconv"

	_ "github.com/mattn/go-sqlite3"
)

type responseData struct {
	Data responseData1Ext
}

type responseData1Ext struct {
	ShopData shopData
}

type shopData struct {
	ID int
}

func fetchInfo(id string, client http.Client) (data *responseData, err error) {
	res, err := client.Get("https://logging-service.worldtobuild.com/WebService/Set/FetchSetData?SetID=" + id)

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
	} else if data.Data.ShopData.ID == 0 {
		return nil, fmt.Errorf("invalid info json: %+v", data)
	}

	return
}

func Archive(max int, pwd string, client http.Client, db *sql.DB) error {
	_, err := db.Exec("DELETE FROM sets; DELETE FROM sets_parts")

	if err != nil {
		return err
	}

	for i := 1; i <= max; i++ {
		id := strconv.Itoa(i)

		data, err := fetchInfo(id, client)

		if err != nil {
			fmt.Println("\033[91m[SKIP] Set #" + id + " Info: " + err.Error())
			continue
		}

		_, err = db.Exec(
			"REPLACE INTO sets (id, product_id) VALUES (?, ?)",
			i, data.Data.ShopData.ID,
		)

		if err != nil {
			fmt.Println("\033[91m[SKIP] Set #" + id + " Database: " + err.Error())
			continue
		}

		fmt.Println("\033[92m[DONE] Set #" + id + " successfully archived!")
	}

	return nil
}
