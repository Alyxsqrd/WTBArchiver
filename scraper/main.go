package main

import (
	"database/sql"
	"net/http"
	"os"
	"scraper/products"
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

	// err = games.Archive(3146, pwd, client, db)
	// err = designs.Archive(5710, pwd, client, db)
	err = products.Archive(1826, pwd, client, db)
	// err = sets.Archive(99, pwd, client, db)
	// err = clubs.Archive(103, pwd, client, db)
	// err = users.Archive(11859, pwd, client, db)

	if err != nil {
		panic(err)
	}
}
