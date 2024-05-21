package clubs

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
	"time"

	_ "github.com/mattn/go-sqlite3"
)

type clubData struct {
	ID                 int         `json:"-"`
	Name               string      `json:"Name"`
	About              string      `json:"About"`
	JoinType           string      `json:"JoinType"`
	JoinTypeID         int         `json:"-"`
	VerificationIcon   bool        `json:"VerificationIcon"`
	OwnerID            interface{} `json:"OwnerID"`
	CreationDateFormat string      `json:"CreationDateFormat"`
	Emblem             string      `json:"Emblem"`
	MemberCount        int         `json:"MemberCount"`
}

func fetchClubData(clubID string, client http.Client) (*clubData, error) {
	res, err := client.Get("https://api.worldtobuild.com/WebService/Club/FetchClubDataById?ClubID=" + clubID)
	if err != nil {
		return nil, err
	}
	defer res.Body.Close()

	if res.StatusCode != 200 {
		return nil, errors.New("invalid info status: " + strconv.Itoa(res.StatusCode))
	}

	var responseData struct {
		Success bool     `json:"Success"`
		Message string   `json:"Message"`
		Data    clubData `json:"Data"`
	}

	err = json.NewDecoder(res.Body).Decode(&responseData)
	if err != nil {
		return nil, err
	}

	if !responseData.Success {
		return nil, errors.New("API request failed: " + responseData.Message)
	}

	// Parse CreationDateFormat to time.Time and format as UNIX timestamps
	createdAt, err := time.Parse("01-02-2006", responseData.Data.CreationDateFormat)
	if err != nil {
		return nil, err
	}
	creationDate := strconv.FormatInt(createdAt.Unix(), 10) // Format as UNIX timestamp

	// Map JoinType to integer value
	var joinTypeID int
	switch responseData.Data.JoinType {
	case "public":
		joinTypeID = 1
	case "request-only":
		joinTypeID = 2
	case "invite-only":
		joinTypeID = 3
	default:
		joinTypeID = 0 // Default value for unknown types
	}

	return &clubData{
		Name:               responseData.Data.Name,
		About:              responseData.Data.About,
		JoinType:           responseData.Data.JoinType,
		JoinTypeID:         joinTypeID,
		VerificationIcon:   responseData.Data.VerificationIcon,
		OwnerID:            responseData.Data.OwnerID,
		CreationDateFormat: creationDate,
		Emblem:             responseData.Data.Emblem,
		MemberCount:        responseData.Data.MemberCount,
	}, nil
}

func ArchiveClubs(max int, pwd string, client http.Client, db *sql.DB) error {
	_, err := db.Exec("DELETE FROM clubs")
	if err != nil {
		return err
	}

	assetsFolder := "../assets"
	thumbnailsFolder := filepath.Join(assetsFolder, "thumbnails")

	// Create clubs folder inside thumbnails folder if it doesn't exist
	clubsFolder := filepath.Join(thumbnailsFolder, "clubs")
	err = os.MkdirAll(clubsFolder, os.ModePerm)
	if err != nil {
		return err
	}

	for i := 1; i <= max; i++ {
		id := strconv.Itoa(i)

		clubData, err := fetchClubData(id, client)
		if err != nil {
			fmt.Println("\033[91m[SKIP] Club #" + id + " Club Data: " + err.Error())
			continue
		}

		// Download Emblem
		emblemPath := filepath.Join(clubsFolder, id+".png")
		err = downloadFile(clubData.Emblem, emblemPath)
		if err != nil {
			fmt.Println("\033[91m[SKIP] Club #" + id + " Emblem: " + err.Error())
			continue
		}

		_, err = db.Exec(
			"INSERT INTO clubs (id, name, description, join_type_id, is_verified, owner_id, created_at, member_count) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
			i, clubData.Name, clubData.About, clubData.JoinTypeID, clubData.VerificationIcon, clubData.OwnerID, clubData.CreationDateFormat, clubData.MemberCount,
		)
		if err != nil {
			fmt.Println("\033[91m[SKIP] Club #" + id + " Club Database: " + err.Error())
			continue
		}

		fmt.Println("\033[92m[DONE] Club #" + id + " successfully archived!")
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

func Archive(max int, pwd string, client http.Client, db *sql.DB) error {
	return ArchiveClubs(max, pwd, client, db)
}
