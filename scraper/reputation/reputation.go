package reputation

import (
	"database/sql"
	"errors"
	"fmt"
	"net/http"
	"strconv"
	"strings"

	_ "github.com/mattn/go-sqlite3"
	"golang.org/x/net/html"
)

type Reputation struct {
	ID         int
	UserID     int
	Reputation int
}

func fetchReputation(playerID string, client http.Client) (Reputation, error) {
	var reputation Reputation

	// Convert player ID from string to int
	userID, err := strconv.Atoi(playerID)
	if err != nil {
		return reputation, err
	}
	reputation.UserID = userID

	// Fetch HTML content from the API endpoint
	res, err := client.Get("https://www.worldtobuild.com/user/profile?playerId=" + playerID)
	if err != nil {
		return reputation, err
	}
	defer res.Body.Close()

	if res.StatusCode != 200 {
		return reputation, errors.New("invalid API response: " + strconv.Itoa(res.StatusCode))
	}

	doc, err := html.Parse(res.Body)
	if err != nil {
		return reputation, err
	}

	// Extract reputation value from HTML
	var extractReputation func(*html.Node)
	extractReputation = func(n *html.Node) {
		if n.Type == html.ElementNode && n.Data == "div" {
			for _, attr := range n.Attr {
				if attr.Key == "class" && attr.Val == "value" && n.FirstChild != nil {
					reputationStr := strings.TrimSpace(n.FirstChild.Data)
					reputationValue, err := strconv.Atoi(reputationStr)
					if err == nil {
						reputation.Reputation = reputationValue
						return
					}
				}
			}
		}
		for c := n.FirstChild; c != nil; c = c.NextSibling {
			extractReputation(c)
		}
	}
	extractReputation(doc)

	return reputation, nil
}

func updateReputationInUsersTable(db *sql.DB, reputation Reputation) error {
	// Update reputation data in the users table
	stmt, err := db.Prepare("UPDATE users SET reputation = ? WHERE id = ?")
	if err != nil {
		return err
	}
	defer stmt.Close()

	_, err = stmt.Exec(reputation.Reputation, reputation.UserID)
	if err != nil {
		return err
	}

	fmt.Printf("Successfully updated reputation for user ID %d with value %d\n", reputation.UserID, reputation.Reputation)

	return nil
}

func Archive(max int, pwd string, client http.Client, db *sql.DB) error {
	// Start with ID 1
	currentID := 1

	// Loop through player IDs from 1 to the maximum number
	for i := 1; i <= max; i++ {
		playerID := strconv.Itoa(i)

		// Fetch reputation for the current player ID
		reputation, err := fetchReputation(playerID, client)
		if err != nil {
			fmt.Printf("Error fetching reputation for player ID %s: %v\n", playerID, err)
			continue
		}

		// Update reputation in the users table
		err = updateReputationInUsersTable(db, reputation)
		if err != nil {
			fmt.Printf("Error updating reputation in users table for player ID %s: %v\n", playerID, err)
			continue
		}

		// Increment current ID
		currentID++
	}

	return nil
}
