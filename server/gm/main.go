package main

import (
	"embed"
	"fmt"
	"io"
	"log"
	"net/http"
	"net/url"
	"os"

	"github.com/gin-gonic/gin"
)

var (
	//go:embed lib/*
	libs embed.FS
	//go:embed index.html
	index   embed.FS
	webHost = ""
	webPort = "80"
	gmHost  = "127.0.0.1"
	gmPort  = "20001"
	gmCode  = "dnf"

	indexHtml []byte
)

func init() {

	f, _ := index.Open("index.html")
	defer f.Close()
	indexHtml, _ = io.ReadAll(f)

	if os.Getenv("gin.EnvGinMode") != "" && os.Getenv(gin.EnvGinMode) != "" {
		gin.SetMode(os.Getenv(gin.EnvGinMode))
	}

	if os.Getenv("WEB_HOST") != "" && os.Getenv("WEB_HOST") != webHost {
		webHost = os.Getenv("WEB_HOST")
	}

	if os.Getenv("WEB_PORT") != "" && os.Getenv("WEB_PORT") != webPort {
		webPort = os.Getenv("WEB_PORT")
	}

	if os.Getenv("WEB_GM_CODE") != "" && os.Getenv("WEB_GM_CODE") != gmCode {
		gmCode = os.Getenv("WEB_GM_CODE")
	}

	if os.Getenv("GM_SERVER_HOST") != "" && os.Getenv("GM_SERVER_HOST") != gmHost {
		gmHost = os.Getenv("GM_SERVER_HOST")
	}

	if os.Getenv("GM_SERVER_PORT") != "" && os.Getenv("GM_SERVER_PORT") != gmPort {
		gmPort = os.Getenv("GM_SERVER_PORT")
	}
}

func main() {
	r := gin.Default()

	r.POST("/send", func(c *gin.Context) {
		if c.PostForm("code") != gmCode {

			c.JSON(http.StatusOK, gin.H{
				"code":    http.StatusOK,
				"message": "失败",
			})

			return
		} else {
			urlStr := fmt.Sprintf("http://%s:%s/gm/sendItems", gmHost, gmPort)
			formData := url.Values{}
			formData.Set("userName", c.PostForm("username"))
			formData.Set("title", "DNF手游")
			formData.Set("massage", "GM发福利")
			formData.Set("items", fmt.Sprintf("%s@%s", c.PostForm("itemNo"), c.PostForm("itemNum")))

			resp, err := http.PostForm(urlStr, formData)

			if err != nil {
				c.JSON(http.StatusOK, gin.H{
					"code":    http.StatusOK,
					"message": err,
				})

				return
			}
			defer resp.Body.Close()

			if b, err := io.ReadAll(resp.Body); err != nil {
				c.JSON(http.StatusOK, gin.H{
					"code":    http.StatusOK,
					"message": err,
				})

				return
			} else {
				c.JSON(http.StatusOK, gin.H{
					"code":    http.StatusOK,
					"message": string(b),
				})
			}
		}
	})

	r.GET("/index.html", homeFunc)
	r.GET("/", homeFunc)
	r.GET("/lib/*filepath", gin.WrapH(http.FileServer(http.FS(libs))))

	r.GET("/download/*filepath", gin.WrapH(http.FileServer(http.Dir("."))))

	log.Fatalln(r.Run(fmt.Sprintf("%s:%s", webHost, webPort)))
}

func homeFunc(ctx *gin.Context) {
	ctx.Writer.Write(indexHtml)
}
