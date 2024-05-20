package forum_posts

import (
	"database/sql"
	"errors"
	"fmt"
	"net/http"
	"strconv"
	"strings"
	"time"

	"scraper/utils"

	_ "github.com/mattn/go-sqlite3"
	"golang.org/x/net/html"
)

type ForumPost struct {
	ID         int
	Title      string
	CategoryID int
	Body       string
	IsLocked   bool
	IsPinned   bool
	Views      int
	AuthorID   int
	CreatedAt  int64
}

func fetchForumPost(id string, client http.Client) (ForumPost, error) {

	var forumPost ForumPost

	// Convert id from string to int
	forumPostID, err := strconv.Atoi(id)
	if err != nil {
		return forumPost, err
	}
	forumPost.ID = forumPostID

	// Fetch from worldtobuild.com
	res, err := client.Get("https://www.worldtobuild.com/forum/thread?threadId=" + id)
	if err != nil {
		return forumPost, err
	}
	defer res.Body.Close()

	if res.StatusCode != 200 {
		return forumPost, errors.New("invalid forum post status: " + strconv.Itoa(res.StatusCode))
	}

	doc, err := html.Parse(res.Body)
	if err != nil {
		return forumPost, err
	}

	// Extract title
	var extractTitle func(*html.Node)
	extractTitle = func(n *html.Node) {
		if n.Type == html.ElementNode && n.Data == "h2" {
			for _, attr := range n.Attr {
				if attr.Key == "class" && attr.Val == "heavy" && n.FirstChild != nil {
					forumPost.Title = n.FirstChild.Data
					return
				}
			}
		}
		for c := n.FirstChild; c != nil; c = c.NextSibling {
			extractTitle(c)
		}
	}
	extractTitle(doc)

	// Extract body
	var extractBody func(*html.Node)
	extractBody = func(n *html.Node) {
		if n.Type == html.ElementNode && n.Data == "div" {
			for _, attr := range n.Attr {
				if attr.Key == "id" && attr.Val == "main-thread-body" {
					var sb strings.Builder
					for c := n.FirstChild; c != nil; c = c.NextSibling {
						html.Render(&sb, c)
					}
					forumPost.Body = strings.TrimSpace(sb.String()) // Remove leading and trailing whitespace
					return
				}
			}
		}
		for c := n.FirstChild; c != nil; c = c.NextSibling {
			extractBody(c)
		}
	}
	extractBody(doc)

	// Extract is_locked status
	var extractLockedStatus func(*html.Node)
	extractLockedStatus = func(n *html.Node) {
		if n.Type == html.ElementNode && n.Data == "div" {
			for _, attr := range n.Attr {
				if attr.Key == "class" {
					if attr.Val == "thread-locked show" {
						forumPost.IsLocked = true
						return
					} else if attr.Val == "thread-locked hide" {
						forumPost.IsLocked = false
						return
					}
				}
			}
		}
		for c := n.FirstChild; c != nil; c = c.NextSibling {
			extractLockedStatus(c)
		}
	}
	extractLockedStatus(doc)

	// Extract is_pinned status
	var extractPinnedStatus func(*html.Node)
	extractPinnedStatus = func(n *html.Node) {
		if n.Type == html.ElementNode && n.Data == "div" {
			for _, attr := range n.Attr {
				if attr.Key == "class" {
					if attr.Val == "thread-pinned show" {
						forumPost.IsPinned = true
						return
					} else if attr.Val == "thread-pinned hide" {
						forumPost.IsPinned = false
						return
					}
				}
			}
		}
		for c := n.FirstChild; c != nil; c = c.NextSibling {
			extractPinnedStatus(c)
		}
	}
	extractPinnedStatus(doc)

	// Extract views
	var extractViews func(*html.Node)
	extractViews = func(n *html.Node) {
		if n.Type == html.ElementNode && n.Data == "div" {
			if n.FirstChild != nil && n.FirstChild.Type == html.TextNode && strings.TrimSpace(n.FirstChild.Data) == "views" {
				// Find the sibling div with class "value" containing the views count
				sibling := n.NextSibling
				for sibling != nil {
					if sibling.Type == html.ElementNode && sibling.Data == "div" {
						for _, attr := range sibling.Attr {
							if attr.Key == "class" && attr.Val == "value" {
								viewsStr := strings.TrimSpace(sibling.FirstChild.Data)
								views, err := strconv.Atoi(viewsStr)
								if err == nil {
									forumPost.Views = views
								}
								return
							}
						}
					}
					sibling = sibling.NextSibling
				}
			}
		}
		for c := n.FirstChild; c != nil; c = c.NextSibling {
			extractViews(c)
		}
	}

	extractViews(doc)

	// Extract author_id
	var extractAuthorID func(*html.Node)
	extractAuthorID = func(n *html.Node) {
		if n.Type == html.ElementNode && n.Data == "div" {
			for _, attr := range n.Attr {
				if attr.Key == "class" && attr.Val == "auto cell creator" {
					for c := n.FirstChild; c != nil; c = c.NextSibling {
						if c.Type == html.ElementNode && c.Data == "a" {
							for _, attr := range c.Attr {
								if attr.Key == "href" {
									parts := strings.Split(attr.Val, "=")
									if len(parts) > 1 {
										authorIDStr := parts[len(parts)-1]
										authorID, err := strconv.Atoi(authorIDStr)
										if err == nil {
											forumPost.AuthorID = authorID
										}
									}
								}
							}
						}
					}
				}
			}
		}
		for c := n.FirstChild; c != nil; c = c.NextSibling {
			extractAuthorID(c)
		}
	}
	extractAuthorID(doc)

	// Extract created_at
	var extractCreatedAt func(*html.Node)
	extractCreatedAt = func(n *html.Node) {
		if n.Type == html.ElementNode && n.Data == "div" {
			for _, attr := range n.Attr {
				if attr.Key == "class" && attr.Val == "shrink cell post-date" {
					for c := n.FirstChild; c != nil; c = c.NextSibling {
						if c.Type == html.ElementNode && c.Data == "div" {
							for _, attr := range c.Attr {
								if attr.Key == "class" && attr.Val == "value" {
									for _, attr := range c.Attr {
										if attr.Key == "title" {
											layout := "January 2, 2006 3:04pm"
											t, err := time.Parse(layout, attr.Val)
											if err == nil {
												forumPost.CreatedAt = t.Unix()
											}
											return
										}
									}
								}
							}
						}
					}
				}
			}
		}
		for c := n.FirstChild; c != nil; c = c.NextSibling {
			extractCreatedAt(c)
		}
	}
	extractCreatedAt(doc)

	return forumPost, nil
}

func fetchCategoryID(id string, client http.Client) (int, error) {
	res, err := client.Get("https://lake.worldtobuild.com/forum/topic/" + id)
	if err != nil {
		return 0, err
	}
	defer res.Body.Close()

	if res.StatusCode != 200 {
		return 0, errors.New("invalid category fetch status: " + strconv.Itoa(res.StatusCode))
	}

	doc, err := html.Parse(res.Body)
	if err != nil {
		return 0, err
	}

	var categoryID int
	var extractCategoryID func(*html.Node)
	extractCategoryID = func(n *html.Node) {
		if n.Type == html.ElementNode && n.Data == "a" {
			for _, attr := range n.Attr {
				if attr.Key == "href" && strings.Contains(attr.Val, "/forum/subforum/") {
					parts := strings.Split(attr.Val, "/")
					if len(parts) > 3 {
						categoryIDStr := parts[3]
						categoryID, _ = strconv.Atoi(categoryIDStr)
						return
					}
				}
			}
		}
		for c := n.FirstChild; c != nil; c = c.NextSibling {
			extractCategoryID(c)
		}
	}
	extractCategoryID(doc)

	return categoryID, nil
}

func Archive(max int, pwd string, client http.Client, db *sql.DB) error {
	// Clear the forum_threads table
	_, err := db.Exec("DELETE FROM forum_threads")
	if err != nil {
		return err
	}

	// Define range of IDs to scrape
	startID := 1

	for i := startID; i <= max; i++ {
		id := strconv.Itoa(i)

		forumPost, err := fetchForumPost(id, client)
		if err != nil {
			fmt.Println("Error fetching forum post:", err)
			continue
		}

		categoryID, err := fetchCategoryID(id, client)
		if err != nil {
			fmt.Println("Error fetching category ID:", err)
			continue
		}
		forumPost.CategoryID = categoryID

		// Insert scraped data into database
		stmt, err := db.Prepare("INSERT INTO forum_threads (id, title, category_id, body, is_locked, is_pinned, views, author_id, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)")
		if err != nil {
			fmt.Println("Error preparing SQL statement:", err)
			continue
		}
		defer stmt.Close()

		sanitizedTitle := utils.SanitizeString(forumPost.Title)
		sanitizedBody := utils.SanitizeString(forumPost.Body)

		_, err = stmt.Exec(forumPost.ID, sanitizedTitle, forumPost.CategoryID, sanitizedBody, forumPost.IsLocked, forumPost.IsPinned, forumPost.Views, forumPost.AuthorID, forumPost.CreatedAt)
		if err != nil {
			fmt.Println("Error executing SQL statement:", err)
			continue
		}

		fmt.Printf("Successfully archived forum post with ID: %s (Category ID: %d, Created At: %d)\n", id, forumPost.CategoryID, forumPost.CreatedAt)
	}

	return nil
}
