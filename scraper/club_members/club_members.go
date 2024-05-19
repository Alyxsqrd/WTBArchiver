package club_members

import (
	"database/sql"
	"encoding/json"
	"errors"
	"fmt"
	"net/http"
	"strconv"

	_ "github.com/mattn/go-sqlite3"
)

type UserData struct {
	UserID int `json:"UserID"`
}

type RoleData struct {
	ClubID int `json:"ClubID"`
	Rank   int `json:"Rank"`
}

// Fetch club member data with pagination support
func fetchClubMemberData(id int, client http.Client) ([]UserData, []RoleData, error) {
	var allUserData []UserData
	var allRoleData []RoleData
	nextPage := 1

	for nextPage != 0 {
		url := fmt.Sprintf("https://lake.worldtobuild.com/api/club/GetClubMembersByRoleSet/%d/%d", id, nextPage)
		res, err := client.Get(url)
		if err != nil {
			return nil, nil, err
		}
		defer res.Body.Close()

		if res.StatusCode != 200 {
			return nil, nil, errors.New("invalid status: " + strconv.Itoa(res.StatusCode))
		}

		var responseData struct {
			Success  bool       `json:"Success"`
			Message  string     `json:"Message"`
			Data     []UserData `json:"Data"`
			RoleData []RoleData `json:"RoleData"`
			NextPage *int       `json:"NextPage"`
		}

		err = json.NewDecoder(res.Body).Decode(&responseData)
		if err != nil {
			return nil, nil, err
		}

		if !responseData.Success {
			return nil, nil, errors.New("API request failed: " + responseData.Message)
		}

		allUserData = append(allUserData, responseData.Data...)
		allRoleData = responseData.RoleData

		if responseData.NextPage != nil {
			nextPage = *responseData.NextPage
		} else {
			nextPage = 0
		}
	}

	return allUserData, allRoleData, nil
}

func logError(message string) {
	fmt.Println("[ERROR]", message)
}

func Archive(max int, pwd string, client http.Client, db *sql.DB) error {
	// Clear the clubs_members table
	_, err := db.Exec("DELETE FROM clubs_members")
	if err != nil {
		return err
	}

	for i := 1; i <= max; i++ {
		userData, roleData, err := fetchClubMemberData(i, client)
		if err != nil {
			logError("Failed to fetch member data for Club #" + strconv.Itoa(i) + ": " + err.Error())
			continue
		}

		// Assuming there's only one RoleData entry per club
		if len(roleData) == 0 {
			logError("No role data found for Club #" + strconv.Itoa(i))
			continue
		}
		roleRank := roleData[0].Rank
		clubID := roleData[0].ClubID

		for _, user := range userData {
			_, err = db.Exec(
				"INSERT INTO clubs_members (club_ID, role_ID, user_ID) VALUES (?, ?, ?)",
				clubID, roleRank, user.UserID,
			)
			if err != nil {
				logError("Failed to insert member data for Club #" + strconv.Itoa(clubID) + ": " + err.Error())
				continue
			}

			fmt.Println("[DONE] Member for Club #" + strconv.Itoa(clubID) + " successfully archived!")
		}
	}

	return nil
}
