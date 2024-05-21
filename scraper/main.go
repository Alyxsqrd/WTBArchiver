package main

import (
	"database/sql"
	"net/http"
	"os"
)

func main() {
	pwd, err := os.Getwd()

	if err != nil {
		panic(err)
	}

	db, err := sql.Open("sqlite3", "../archive.db")

	if err != nil {
		panic(err)
	}

	client := http.Client{}

	// Game Archival Tools ----------------------

	// err = games.Archive(3158, pwd, client, db)

	// ------------------------------------------

	// Achievement Archival Tools ----------------------

	// err = achievements.Archive(35, pwd, client, db)
	// err = user_achievements.Archive(11907, pwd, client, db)

	// -------------------------------------------------

	// Club Archival Tools -----------------------------

	// err = clubs.Archive(103, pwd, client, db)
	// err = club_roles.Archive(468, pwd, client, db)
	// err = club_members.Archive(468, pwd, client, db)

	// -------------------------------------------------

	// Sets Archival Tools -----------------------------

	// err = sets.Archive(99, pwd, client, db)

	// -------------------------------------------------

	// Pets Archival Tools -----------------------------

	// err = pets.Archive(26, pwd, client, db)

	// -------------------------------------------------

	// User Archival Tools -----------------------------

	// err = users.Archive(11907, pwd, client, db)
	// err = reputation.Archive(11907, pwd, client, db)

	// -------------------------------------------------

	// Forum Archival Tools -----------------------------

	// err = forum_replies.Archive(2856, pwd, client, db)
	// err = forum_posts.Archive(2856, pwd, client, db)

	// -------------------------------------------------

	// Design Archival Tools -----------------------------

	// err = designs.Archive(5720, pwd, client, db)

	// -------------------------------------------------

	// Product Archival Tools -----------------------------

	// err = products.Archive(1826, pwd, client, db)

	// -------------------------------------------------

	if err != nil {
		panic(err)
	}
}
