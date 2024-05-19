package forum_replies

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

type UserData struct {
	UserID   int    `json:"UserID"`
	Username string `json:"Username"`
}

type ReplyData struct {
	ID   int    `json:"ID"`
	Text string `json:"Text"`
	Date string `json:"FullDate"`
}

type ForumResponse struct {
	Success    bool        `json:"Success"`
	Message    string      `json:"Message"`
	Results    []struct {
		UserData  UserData  `json:"UserData"`
		ReplyData ReplyData `json:"ReplyData"`
	} `json:"Results"`
	NextCursor string `json:"NextCursor"`
}

func parseDate(dateString string) (int, error) {
	date, err := time.Parse("January 02, 2006 3:04pm", dateString)
	if err != nil {
		return 0, err
	}
	return int(date.Unix()), nil
}

func fetchForumReplies(threadID int, client http.Client) ([]UserData, []ReplyData, error) {
	var allUserData []UserData
	var allReplyData []ReplyData
	nextCursor := ""

	for {
		url := fmt.Sprintf("https://www.worldtobuild.com/api/forum/fetch-replies?threadId=%d", threadID)
		if nextCursor != "" {
			url += "&cursor=" + nextCursor
		}

		res, err := client.Get(url)
		if err != nil {
			return nil, nil, err
		}
		defer res.Body.Close()

		if res.StatusCode != 200 {
			return nil, nil, errors.New("invalid status: " + strconv.Itoa(res.StatusCode))
		}

		var responseData ForumResponse
		err = json.NewDecoder(res.Body).Decode(&responseData)
		if err != nil {
			return nil, nil, err
		}

		if !responseData.Success {
			return nil, nil, errors.New("API request failed: " + responseData.Message)
		}

		for _, result := range responseData.Results {
			allUserData = append(allUserData, result.UserData)
			allReplyData = append(allReplyData, result.ReplyData)
		}

		if responseData.NextCursor != "" {
			nextCursor = responseData.NextCursor
		} else {
			break // Exit the loop if there's no next cursor
		}
	}

	return allUserData, allReplyData, nil
}

func Archive(threadID int, pwd string, client http.Client, db *sql.DB) error {
	_, err := db.Exec("DELETE FROM forum_replies WHERE thread_id = ?", threadID)
	if err != nil {
		return err
	}

	userData, replyData, err := fetchForumReplies(threadID, client)
	if err != nil {
		return err
	}

	for i, reply := range replyData {
		user := userData[i]

		createdAt, err := parseDate(reply.Date)
		if err != nil {
			return err
		}

		_, err = db.Exec(
			"INSERT INTO forum_replies (thread_id, body, author_id, created_at) VALUES (?, ?, ?, ?)",
			threadID, reply.Text, user.UserID, createdAt,
		)
		if err != nil {
			return err
		}

		fmt.Println("[DONE] Reply by " + user.Username + " archived!")
	}

	return nil
}
