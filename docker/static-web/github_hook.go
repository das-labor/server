package main

import (
	"encoding/json"
	"fmt"
	"html"
	"net/http"
	"net/url"
	"os"
	"os/exec"
	"os/user"
	"strconv"
	"strings"
)

type Site struct {
	Repo       url.URL
	Path       string
	UsesJekyll bool
}

const WwwBase string = "/var/www/"
const WwwUser string = "www-data"

var sites []Site
var WwwUid int
var WwwGid int

func rootHandler(w http.ResponseWriter, r *http.Request) {
	if r.URL.Path == "/github" &&
		r.Method == "POST" &&
		r.Header.Get("X-GitHub-Event") == "push" {

		dec := json.NewDecoder(r.Body)

		var msg map[string]interface{}
		err := dec.Decode(&msg)

		if err != nil {
			http.Error(w, "Failed to parse JSON: "+err.Error(), 400)
		} else {
			repo := msg["repository"].(map[string]interface{})
			repo_url, err := url.Parse(repo["clone_url"].(string))

			if err != nil {
				http.Error(w, "Can't parse clone_url", 400)
			} else {
				for _, st := range sites {
					if st.Repo == *repo_url {
						git_cmd := exec.Command("/bin/bash", "-c", "git fetch origin master && git reset --hard FETCH_HEAD && git clean -df")
						git_cmd.Dir = st.Path

						out, err := git_cmd.Output()
						if err != nil {
							fmt.Printf("Failed to run git in %q: %s\n", git_cmd.Dir, err.Error())
							http.Error(w, "Failed to run git pull: "+err.Error(), 500)
						} else {
							if st.UsesJekyll {
								jekyll_cmd := exec.Command("/bin/bash", "-c", "jekyll build")
								jekyll_cmd.Dir = st.Path

								jekyll_out, err := jekyll_cmd.Output()
								if err != nil {
									fmt.Printf("Failed to run jekyll build: %s\n", err.Error())
									http.Error(w, "Failed to run jekyll build: "+err.Error(), 500)
									return
								}

								out = append(out, jekyll_out...)
							}

							var chown func(string)
							chown = func(dir string) {
								os.Chown(dir, WwwUid, WwwGid)
								fd, err := os.Open(dir)

								if err == nil {
									names, err := fd.Readdirnames(0)

									if err == nil {
										for _, s := range names {
											if s != "." && s != ".." {
												chown(dir + "/" + s)
											}
										}
									}
								}
							}

							chown(st.Path)

							fmt.Fprintf(w, "Event for %q\nOutput: %q",
								html.EscapeString(repo_url.String()),
								html.EscapeString(string(out)))
						}

						return
					}
				}

				fmt.Printf("Unknown site: %s\n", repo_url)
				http.Error(w, "Unknown site", 404)
				return
			}
		}
	}

	http.Error(w, "Wat?", 500)
}

func main() {
	for _, e := range os.Environ() {
		evar := strings.Split(e, "=")

		if len(evar) == 2 && strings.HasPrefix(evar[0], "STATIC_SITE_") {
			site := strings.Split(evar[1], ",")

			if len(site) == 3 {
				r, err := url.Parse(site[1])

				if err == nil {
					st := Site{
						Repo:       *r,
						Path:       WwwBase + site[0],
						UsesJekyll: (site[2] == "true"),
					}

					if st.UsesJekyll {
						fmt.Printf("Registed Jekyll site %q cloned from %q\n", site[0], r)
					} else {
						fmt.Printf("Registed site %q cloned from %q\n", site[0], r)
					}
					sites = append(sites, st)
				}
			}
		}
	}

	wwwUser, err := user.Lookup(WwwUser)
	if err == nil {
		WwwUid, err = strconv.Atoi(wwwUser.Uid)

		if err == nil {
			WwwGid, err = strconv.Atoi(wwwUser.Gid)

			if err == nil {

				http.HandleFunc("/github", rootHandler)
				http.ListenAndServe("127.0.0.1:3000", nil)
				return
			}
		}
	}
	fmt.Printf("Can't find user %q\n", WwwUser)
}
