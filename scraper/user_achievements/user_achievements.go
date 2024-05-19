package user_achievements

import (
	"database/sql"
	"encoding/json"
	"errors"
	"fmt"
	"net/http"
	"strconv"

	_ "github.com/mattn/go-sqlite3"
)

type AchievementData struct {
	ID           int    `json:"ID"`
	TrophyNumber int    `json:"TrophyNumber"`
	Title        string `json:"Title"`
	Icon         string `json:"Icon"`
}

// Fetch user achievement data with pagination support
func fetchUserAchievementData(id int, client http.Client) ([]AchievementData, error) {
	var allAchievementData []AchievementData
	nextCursor := ""

	for {
		url := fmt.Sprintf("https://www.worldtobuild.com/api/user/fetch-trophies?playerId=%d", id)
		if nextCursor != "" {
			url += "&cursor=" + nextCursor
		}

		res, err := client.Get(url)
		if err != nil {
			return nil, err
		}
		defer res.Body.Close()

		if res.StatusCode != 200 {
			return nil, errors.New("invalid status: " + strconv.Itoa(res.StatusCode))
		}

		var responseData struct {
			Success    bool              `json:"Success"`
			Message    string            `json:"Message"`
			Results    []AchievementData `json:"Results"`
			NextCursor string            `json:"NextCursor"`
		}

		err = json.NewDecoder(res.Body).Decode(&responseData)
		if err != nil {
			return nil, err
		}

		if !responseData.Success {
			return nil, errors.New("API request failed: " + responseData.Message)
		}

		allAchievementData = append(allAchievementData, responseData.Results...)

		if responseData.NextCursor != "" {
			nextCursor = responseData.NextCursor
		} else {
			break
		}
	}

	return allAchievementData, nil
}

func logError(message string) {
	fmt.Println("[ERROR]", message)
}

// Archive fetches user achievement data and archives it in the database
func Archive(max int, pwd string, client http.Client, db *sql.DB) error {
	// Clear the users_achievements table
	_, err := db.Exec("DELETE FROM users_achievements")
	if err != nil {
		return err
	}

	for i := 1; i <= max; i++ {
		achievementData, err := fetchUserAchievementData(i, client)
		if err != nil {
			logError("Failed to fetch achievement data for User #" + strconv.Itoa(i) + ": " + err.Error())
			continue
		}

		for _, achievement := range achievementData {
			_, err = db.Exec(
				"INSERT INTO users_achievements (user_id, achievement_id) VALUES (?, ?)",
				i, achievement.TrophyNumber,
			)
			if err != nil {
				logError("Failed to insert achievement data for User #" + strconv.Itoa(i) + ": " + err.Error())
				continue
			}

			fmt.Println("[DONE] Achievement for User #" + strconv.Itoa(i) + " successfully archived!")
		}
	}

	return nil
}
