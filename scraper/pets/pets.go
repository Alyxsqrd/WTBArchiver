package pets

import (
	"database/sql"
	"encoding/json"
	"errors"
	"fmt"
	"net/http"
	"strconv"

	_ "github.com/mattn/go-sqlite3"
)

type petData struct {
	PetID        int     `json:"PetID"`
	BundleID     int     `json:"BundleID"`
	Scale        float64 `json:"Scale"`
	MovementType int     `json:"MovementType"`
}

func fetchPetData(petID string, client http.Client) (*petData, error) {
	res, err := client.Get("https://api.worldtobuild.com/game/fetch-pet-instance.php?petID=" + petID)
	if err != nil {
		return nil, err
	}
	defer res.Body.Close()

	if res.StatusCode != 200 {
		return nil, errors.New("invalid info status: " + strconv.Itoa(res.StatusCode))
	}

	var responseData petData
	err = json.NewDecoder(res.Body).Decode(&responseData)
	if err != nil {
		return nil, err
	}

	return &responseData, nil
}

func ArchivePets(max int, client http.Client, db *sql.DB) error {
	_, err := db.Exec("DELETE FROM pets")
	if err != nil {
		return err
	}

	for i := 1; i <= max; i++ {
		id := strconv.Itoa(i)

		petData, err := fetchPetData(id, client)
		if err != nil {
			fmt.Println("\033[91m[SKIP] Pet #" + id + ": " + err.Error())
			continue
		}

		_, err = db.Exec(
			"INSERT INTO pets (ID, design_id, scale, movement_type_id) VALUES (?, ?, ?, ?)",
			petData.PetID, petData.BundleID, petData.Scale, petData.MovementType,
		)
		if err != nil {
			fmt.Println("\033[91m[SKIP] Pet #" + id + ": " + err.Error())
			continue
		}

		fmt.Println("\033[92m[DONE] Pet #" + id + " successfully archived!")
	}

	return nil
}

func Archive(max int, pwd string, client http.Client, db *sql.DB) error {
	return ArchivePets(max, client, db)
}
