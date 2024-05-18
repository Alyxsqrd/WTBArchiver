package achievements

import (
	"database/sql"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"net/http"
	"os"
	"path/filepath"
	"strconv"

	_ "github.com/mattn/go-sqlite3"
)

type trophyData struct {
	BadgeName   string `json:"BadgeName"`
	Icon        string `json:"Icon"`
	Description string `json:"Description"`
	Special     int    `json:"Special"`
	Event       int    `json:"Event"`
}

func fetchTrophyData(trophyID string, client http.Client) (*trophyData, error) {
	res, err := client.Get("https://www.worldtobuild.com/api/community/fetch-trophy-data?trophyId=" + trophyID)
	if err != nil {
		return nil, err
	}
	defer res.Body.Close()

	if res.StatusCode != 200 {
		return nil, errors.New("invalid status: " + strconv.Itoa(res.StatusCode))
	}

	var responseData struct {
		Success bool       `json:"Success"`
		Message string     `json:"Message"`
		Data    trophyData `json:"Data"`
	}

	err = json.NewDecoder(res.Body).Decode(&responseData)
	if err != nil {
		return nil, err
	}

	if !responseData.Success {
		return nil, errors.New("API request failed: " + responseData.Message)
	}

	return &responseData.Data, nil
}

func Archive(max int, pwd string, client http.Client, db *sql.DB) error {
	assetsFolder := filepath.Join(pwd, "..", "assets", "thumbnails", "achievements")

	// Ensure the assets folder exists
	err := os.MkdirAll(assetsFolder, os.ModePerm)
	if err != nil {
		return err
	}

	// Clear the achievements table
	_, err = db.Exec("DELETE FROM achievements")
	if err != nil {
		return err
	}

	for i := 1; i <= max; i++ {
		id := strconv.Itoa(i)

		trophyData, err := fetchTrophyData(id, client)
		if err != nil {
			fmt.Println("[SKIP] Trophy #" + id + " Data: " + err.Error())
			continue
		}

		if trophyData.Icon != "" {
			// Download Icon
			iconPath := filepath.Join(assetsFolder, id+".png")
			err = downloadFile(trophyData.Icon, iconPath)
			if err != nil {
				fmt.Println("[SKIP] Trophy #" + id + " Icon: " + err.Error())
				continue
			}
		}

		_, err = db.Exec(
			"INSERT INTO achievements (id, name, description, special, event) VALUES (?, ?, ?, ?, ?)",
			i, trophyData.BadgeName, trophyData.Description, trophyData.Special, trophyData.Event,
		)
		if err != nil {
			fmt.Println("[SKIP] Trophy #" + id + " Database: " + err.Error())
			continue
		}

		fmt.Println("[DONE] Trophy #" + id + " successfully archived!")
	}

	return nil
}

func downloadFile(url string, filepath string) error {
	resp, err := http.Get(url)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	out, err := os.Create(filepath)
	if err != nil {
		return err
	}
	defer out.Close()

	_, err = io.Copy(out, resp.Body)
	if err != nil {
		return err
	}

	return nil
}
