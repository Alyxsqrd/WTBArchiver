package main

import (
	"database/sql"
	"net/http"
	"os"
	"scraper/user_achievements"
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

	// err = games.Archive(3158, pwd, client, db)
	// err = achievements.Archive(35, pwd, client, db)
	// err = designs.Archive(5720, pwd, client, db)
	// err = products.Archive(1826, pwd, client, db)
	// err = sets.Archive(99, pwd, client, db)
	// err = clubs.Archive(103, pwd, client, db)
	// err = club_roles.Archive(468, pwd, client, db)
	//err = club_members.Archive(468, pwd, client, db)
	err = user_achievements.Archive(11907, pwd, client, db)
	// err = users.Archive(11907, pwd, client, db)

	if err != nil {
		panic(err)
	}
}
