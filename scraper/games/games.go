package games

import (
	"compress/gzip"
	"database/sql"
	"encoding/binary"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"net/http"
	"os"
	"path"
	"path/filepath"
	"scraper/utils"
	"strconv"
	"strings"

	_ "github.com/mattn/go-sqlite3"
)

type responseData1 struct {
	Data responseData1Ext
}

type responseData1Ext struct {
	Name       string
	About      *string
	Preview    string
	OwnerID    int
	TotalPlays int
	Public     bool
	Featured   bool
	Category   int
}

type responseData2 struct {
	GameMaxClients int
	LastUpdate     int
}

type responseData3 struct {
	Package string
	Version int
}

var templateIDs = map[string]int{
	"template_baseplate2022.png":    1, // baseplate
	"template_builderscove2022.png": 2, // builders_cove
	"template_obby2022.png":         3, // obby
	"foundation_thumbnail.png":      4, // legacy_foundation
	"template_builderscove2019.png": 5, // legacy_builders_cove
	"template_obby.png":             6, // legacy_obby
	"template_whiteroom.png":        7, // legacy_white_room
}

func fetchInfo(id string, client http.Client) (data1 *responseData1, data2 *responseData2, data3 *responseData3, err error) {
	res, err := client.Get("https://api.worldtobuild.com/WebService/World/FetchWorldDataById?WorldID=" + id)

	if err != nil {
		return nil, nil, nil, err
	}

	defer res.Body.Close()

	if res.StatusCode != 200 {
		return nil, nil, nil, errors.New("invalid 1st status: " + strconv.Itoa(res.StatusCode))
	}

	err = json.NewDecoder(res.Body).Decode(&data1)

	if err != nil {
		return nil, nil, nil, err
	} else if data1.Data.Preview == "" {
		return nil, nil, nil, fmt.Errorf("invalid 1st json: %+v", data1)
	}

	data1.Data.Name = utils.SanitizeString(data1.Data.Name)

	if data1.Data.About != nil {
		about := utils.SanitizeString(*data1.Data.About)

		if len(about) == 0 {
			data1.Data.About = nil
		} else {
			data1.Data.About = &about
		}
	}

	res, err = client.Get("https://api.worldtobuild.com/game/get-game-information.php?gameID=" + id)

	if err != nil {
		return nil, nil, nil, err
	}

	defer res.Body.Close()

	if res.StatusCode != 200 {
		return nil, nil, nil, errors.New("invalid 2nd status: " + strconv.Itoa(res.StatusCode))
	}

	err = json.NewDecoder(res.Body).Decode(&data2)

	if err != nil {
		return nil, nil, nil, err
	} else if data2.LastUpdate == 0 {
		return nil, nil, nil, fmt.Errorf("invalid 2nd json: %+v", data2)
	}

	res, err = client.Get("https://api.worldtobuild.com/GameService/FetchGameDataById?GameId=" + id)

	if err != nil {
		return nil, nil, nil, err
	}

	defer res.Body.Close()

	if res.StatusCode != 200 {
		return nil, nil, nil, errors.New("invalid 3rd status: " + strconv.Itoa(res.StatusCode))
	}

	err = json.NewDecoder(res.Body).Decode(&data3)

	if err != nil {
		return nil, nil, nil, err
	} else if data3.Package == "" {
		return nil, nil, nil, fmt.Errorf("invalid 3rd json: %+v", data3)
	}

	return
}

func downloadData(id string, version int, hash string, pwd string, client http.Client) error {
	if version < 12 {
		res, err := client.Get("https://api.worldtobuild.com/game/load-game-data.php?id=" + id)

		if err != nil {
			return err
		}

		defer res.Body.Close()

		if res.StatusCode != 200 {
			return errors.New("invalid legacy status: " + strconv.Itoa(res.StatusCode))
		}

		file, err := os.Create(filepath.Join(pwd, id+".wtb"))

		if err != nil {
			return err
		}

		defer file.Close()
		gz := gzip.NewWriter(file)
		defer gz.Close()
		_, err = io.Copy(gz, res.Body)

		return err
	}

	output := filepath.Join(pwd, id)
	err := os.RemoveAll(output)

	if err != nil {
		return err
	}

	res, err := client.Get("http://cdn.worldtobuild.com/xZUaO2nMi0RIHdRnsxLapjzZw3NX/" + hash + "/.worlddata")

	if err != nil {
		return err
	}

	defer res.Body.Close()

	if res.StatusCode != 200 {
		return errors.New("invalid package status: " + strconv.Itoa(res.StatusCode))
	}

	gz, err := gzip.NewReader(res.Body)

	if err != nil {
		return err
	}

	defer gz.Close()

	for {
		var len1 int32
		err = binary.Read(gz, &binary.LittleEndian, &len1)

		if err == io.EOF {
			err = nil
			break
		} else if err != nil {
			return err
		}

		char := make([]byte, 1)
		data := make([]byte, len1)

		for i := int32(0); i < len1; i++ {
			_, err = io.ReadFull(gz, char)

			if err != nil {
				return err
			}

			data[i] = char[0]
			_, err = io.ReadFull(gz, char)

			if err != nil {
				return err
			}
		}

		var len2 int32
		err = binary.Read(gz, &binary.LittleEndian, &len2)

		if err != nil {
			return err
		}

		path := filepath.Join(output, string(data))
		err = os.MkdirAll(filepath.Dir(path), 0664)

		if err != nil {
			return err
		}

		file, err := os.Create(path)

		if err != nil {
			return err
		}

		defer file.Close()
		_, err = io.CopyN(file, gz, int64(len2))

		if err != nil {
			return err
		}
	}

	return nil
}

func downloadThumbnail(id string, url string, pwd string, client http.Client) (*int, error) {
	template := templateIDs[strings.ToLower(path.Base(url))]

	if template > 0 {
		return &template, nil
	}

	res, err := client.Get(url)

	if err != nil {
		return nil, err
	}

	defer res.Body.Close()

	if res.StatusCode != 200 {
		return nil, errors.New("invalid thumbnail status: " + strconv.Itoa(res.StatusCode))
	}

	file, err := os.Create(filepath.Join(pwd, id+".png"))

	if err != nil {
		return nil, err
	}

	defer file.Close()
	_, err = io.Copy(file, res.Body)

	return nil, err
}

func Archive(max int, pwd string, client http.Client, db *sql.DB) error {
	gamesPath := filepath.Join(pwd, "..", "assets", "games")
	err := os.RemoveAll(gamesPath)

	if err != nil {
		return err
	}

	err = os.MkdirAll(gamesPath, 0664)

	if err != nil {
		return err
	}

	thumbnailsPath := filepath.Join(pwd, "..", "assets", "thumbnails", "games")
	os.RemoveAll(thumbnailsPath)

	if err != nil {
		return err
	}

	err = os.MkdirAll(thumbnailsPath, 0664)

	if err != nil {
		return err
	}

	_, err = db.Exec("DELETE FROM games")

	if err != nil {
		return err
	}

	for i := 1; i <= max; i++ {
		id := strconv.Itoa(i)

		data1, data2, data3, err := fetchInfo(id, client)

		if err != nil {
			fmt.Println("\033[91m[SKIP] Game #" + id + " Info: " + err.Error())
			continue
		}

		err = downloadData(id, data3.Version, data3.Package, gamesPath, client)

		if err != nil {
			fmt.Println("\033[91m[SKIP] Game #" + id + " Data: " + err.Error())
			continue
		}

		template, err := downloadThumbnail(id, data1.Data.Preview, thumbnailsPath, client)

		if err != nil {
			fmt.Println("\033[91m[SKIP] Game #" + id + " Thumbnail: " + err.Error())
			continue
		}

		_, err = db.Exec(
			"REPLACE INTO games (id, name, description, category_id, room_size, is_public, is_featured, version, plays, template_id, creator_id, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
			i, data1.Data.Name, data1.Data.About, data1.Data.Category, data2.GameMaxClients, data1.Data.Public, data1.Data.Featured, data3.Version, data1.Data.TotalPlays, template, data1.Data.OwnerID, data2.LastUpdate,
		)

		if err != nil {
			fmt.Println("\033[91m[SKIP] Game #" + id + " Database: " + err.Error())
			continue
		}

		fmt.Println("\033[92m[DONE] Game #" + id + " successfully archived!")
	}

	return nil
}
