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

type QuotingData struct {
	Text string `json:"Text"`
}

type ForumResponse struct {
	Success bool   `json:"Success"`
	Message string `json:"Message"`
	Results []struct {
		UserData    UserData    `json:"UserData"`
		ReplyData   ReplyData   `json:"ReplyData"`
		QuotingData QuotingData `json:"QuoteData"`
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

func fetchForumReplies(threadID int, client http.Client) ([]UserData, []ReplyData, []QuotingData, error) {
	var allUserData []UserData
	var allReplyData []ReplyData
	var allQuotingData []QuotingData
	nextCursor := ""

	for {
		url := fmt.Sprintf("https://www.worldtobuild.com/api/forum/fetch-replies?threadId=%d", threadID)
		if nextCursor != "" {
			url += "&cursor=" + nextCursor
		}

		res, err := client.Get(url)
		if err != nil {
			return nil, nil, nil, err
		}
		defer res.Body.Close()

		if res.StatusCode != 200 {
			return nil, nil, nil, errors.New("invalid status: " + strconv.Itoa(res.StatusCode))
		}

		var responseData ForumResponse
		err = json.NewDecoder(res.Body).Decode(&responseData)
		if err != nil {
			return nil, nil, nil, err
		}

		if !responseData.Success {
			return nil, nil, nil, errors.New("API request failed: " + responseData.Message)
		}

		for _, result := range responseData.Results {
			allUserData = append(allUserData, result.UserData)
			allReplyData = append(allReplyData, result.ReplyData)
			allQuotingData = append(allQuotingData, result.QuotingData)
		}

		if responseData.NextCursor != "" {
			nextCursor = responseData.NextCursor
		} else {
			break // Exit the loop if there's no next cursor
		}
	}

	return allUserData, allReplyData, allQuotingData, nil
}

func Archive(maxThreadID int, pwd string, client http.Client, db *sql.DB) error {
	// Clear the forum_replies table
	_, err := db.Exec("DELETE FROM forum_replies")
	if err != nil {
		return err
	}

	// Iterate over each thread ID up to maxThreadID
	for threadID := 1; threadID <= maxThreadID; threadID++ {
		// Fetch forum replies for the current thread ID
		allUserData, replyData, quotingData, err := fetchForumReplies(threadID, client)
		if err != nil {
			fmt.Printf("Error fetching replies for thread ID %d: %v\n", threadID, err)
			continue // Move to the next thread ID if there's an error
		}

		// Iterate over each reply and archive it
		for i, reply := range replyData {
			createdAt, err := parseDate(reply.Date)
			if err != nil {
				fmt.Printf("Error parsing date for reply ID %d: %v\n", reply.ID, err)
				continue // Move to the next reply if there's an error
			}

			// Handle quoting data
			quotingText := sql.NullString{}
			if quotingData[i].Text != "" {
				quotingText = sql.NullString{String: quotingData[i].Text, Valid: true}
			}

			// Insert the reply into the database
			_, err = db.Exec(
				"INSERT INTO forum_replies (thread_id, body, author_id, created_at, quoting) VALUES (?, ?, ?, ?, ?)",
				threadID, reply.Text, allUserData[i].UserID, createdAt, quotingText,
			)
			if err != nil {
				fmt.Printf("Error inserting reply into database for thread ID %d: %v\n", threadID, err)
				continue // Move to the next reply if there's an error
			}

			fmt.Printf("[DONE] Reply by %s archived for thread ID %d!\n", allUserData[i].Username, threadID)
		}
	}

	return nil
}
