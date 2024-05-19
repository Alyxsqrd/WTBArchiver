package club_roles

import (
	"database/sql"
	"encoding/json"
	"errors"
	"fmt"
	"net/http"
	"strconv"

	_ "github.com/mattn/go-sqlite3"
)

type RoleData struct {
	ClubID  int    `json:"ClubID"`
	Name    string `json:"Name"`
	Excerpt string `json:"Excerpt"`
	Rank    int    `json:"Rank"`
}

func fetchClubRoleData(id int, client http.Client) ([]RoleData, error) {
	url := fmt.Sprintf("https://lake.worldtobuild.com/api/club/GetClubMembersByRoleSet/%d/1", id)
	res, err := client.Get(url)
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
		Data    []RoleData `json:"RoleData"`
	}

	err = json.NewDecoder(res.Body).Decode(&responseData)
	if err != nil {
		return nil, err
	}

	if !responseData.Success {
		return nil, errors.New("API request failed: " + responseData.Message)
	}

	return responseData.Data, nil
}

func logError(message string) {
	fmt.Println("[ERROR]", message)
}

func Archive(max int, pwd string, client http.Client, db *sql.DB) error {
	// Clear the clubs_roles table
	_, err := db.Exec("DELETE FROM clubs_roles")
	if err != nil {
		return err
	}

	for i := 1; i <= max; i++ {
		roleData, err := fetchClubRoleData(i, client)
		if err != nil {
			logError("Failed to fetch role data for Club #" + strconv.Itoa(i) + ": " + err.Error())
			continue
		}

		for _, role := range roleData {
			_, err = db.Exec(
				"INSERT INTO clubs_roles (club_ID, name, excerpt, rank) VALUES (?, ?, ?, ?)",
				role.ClubID, role.Name, role.Excerpt, role.Rank,
			)
			if err != nil {
				logError("Failed to insert role data for Club #" + strconv.Itoa(role.ClubID) + ": " + err.Error())
				continue
			}

			fmt.Println("[DONE] Role for Club #" + strconv.Itoa(role.ClubID) + " successfully archived!")
		}
	}

	return nil
}
