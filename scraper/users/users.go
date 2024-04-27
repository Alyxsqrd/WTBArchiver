package users

import (
	"database/sql"
	"encoding/json"
	"errors"
	"fmt"
	"net/http"
	"strconv"
	"time"

	_ "github.com/mattn/go-sqlite3"
)

type playerData struct {
	Username          string `json:"Username"`
	Nickname          string `json:"Nickname"`
	About             string `json:"About"`
	ChatColor         string `json:"ChatColor"`
	CharacterImage    string `json:"CharacterImage"`
	CharacterHeadshot string `json:"CharacterHeadshot"`
	RegisterDate      string `json:"RegisterDate"`
	LastOnline        string `json:"LastOnline"`
	LastOnlineDate    string `json:"LastOnlineDate"`
	IsMembership      bool   `json:"IsMembership"`
	MembershipLevel   string `json:"MembershipLevel"`
	VerificationIcon  bool   `json:"VerificationIcon"`
	RegisteredAt      string `json:"-"`
	LastSeenAt        string `json:"-"`
}

func fetchPlayerData(playerID string, client http.Client) (*playerData, error) {
	res, err := client.Get("https://api.worldtobuild.com/WebService/Player/FetchPlayerDataById?PlayerID=" + playerID)
	if err != nil {
		return nil, err
	}
	defer res.Body.Close()

	if res.StatusCode != 200 {
		return nil, errors.New("invalid info status: " + strconv.Itoa(res.StatusCode))
	}

	var responseData struct {
		Success bool       `json:"Success"`
		Message string     `json:"Message"`
		Data    playerData `json:"Data"`
	}

	err = json.NewDecoder(res.Body).Decode(&responseData)
	if err != nil {
		return nil, err
	}

	if !responseData.Success {
		return nil, errors.New("API request failed: " + responseData.Message)
	}

	// Parse RegisterDate and LastOnlineDate to time.Time and format as UNIX timestamps
	registeredAt, err := time.Parse("01-02-2006", responseData.Data.RegisterDate)
	if err != nil {
		return nil, err
	}
	responseData.Data.RegisteredAt = strconv.FormatInt(registeredAt.Unix(), 10) // Format as UNIX timestamp

	lastSeenAt, err := time.Parse("01-02-2006 3:04pm", responseData.Data.LastOnlineDate)
	if err != nil {
		return nil, err
	}
	responseData.Data.LastSeenAt = strconv.FormatInt(lastSeenAt.Unix(), 10) // Format as UNIX timestamp

	return &responseData.Data, nil
}

func Archive(max int, pwd string, client http.Client, db *sql.DB) error {
	_, err := db.Exec("DELETE FROM users")
	if err != nil {
		return err
	}

	for i := 1; i <= max; i++ {
		id := strconv.Itoa(i)

		playerData, err := fetchPlayerData(id, client)
		if err != nil {
			fmt.Println("\033[91m[SKIP] User #" + id + " Player Data: " + err.Error())
			continue
		}

		lastSeenAt, err := time.Parse("01-02-2006 3:04pm", playerData.LastOnlineDate)
		if err != nil {
			fmt.Println("\033[91m[SKIP] User #" + id + " LastOnlineDate Parsing: " + err.Error())
			continue
		}

		_, err = db.Exec(
			"INSERT INTO users (id, username, nickname, blurb, chat_color, registered_at, last_seen_at) VALUES (?, ?, ?, ?, ?, ?, ?)",
			i, playerData.Username, playerData.Nickname, playerData.About, playerData.ChatColor, playerData.RegisteredAt, lastSeenAt.Unix(),
		)
		if err != nil {
			fmt.Println("\033[91m[SKIP] User #" + id + " Player Database: " + err.Error())
			continue
		}

		fmt.Println("\033[92m[DONE] User #" + id + " successfully archived!")
	}

	return nil
}
