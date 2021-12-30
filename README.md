# SiteSync

SiteSync is my flexible static-site generator.
The script can do the following:

* Initialize a website directory with the minimum amount of files and structure that the script needs to run the "build" command
* Generate a local, "testing" version of the website where you can make and view changes before making it live
* Generate a public version of the site, which can be mirrored to where it is served from with a user-configured deploy command

## Install

1. Install this script by cloning this repository

`git clone this_page's_url`

2. cd into the cloned repositority directory

`cd sitesync`

3. Install the script with make

`make install`

The script installs at *.local/bin/*, and the manual installs at .local/share/man/man1/sitesync.1

Access the manual page with `man sitesync`


## Commands

SiteSync uses the following syntax:

sitesync [OPTION] [DIRECTORY]

### Options

These are SiteSync's available options:

#### init

**init**
: Creates a new website directory, with the minimal structure and files necessary for the **build** option to work

#### build

**build**
: Performs the following actions to build a local version of the website:

* Syncs html files from the *content/* directory in the *local/* directory
* Converts Markdown files in the *content/* directory into html files in the *local/* directory
* Builds a blog page with links to any files stored in the */content/blog/* directory (blog.html is the default blog file)
* Wraps all html files in the template stored in the *assets/template.html* file
* Creates links to the root directory by replacing the `{{ root }}` template placeholder with the proper link back to the website root
* Generates a sitemap.xml file and stores it in *assets/sitemap.xml*
* Copies all non-html files from the *assets/* directory to the *local/* directory

After running the **build** command, the user can open their website in their web browser at *file:///absolute/path/to/website/local/index.html*

You may also run a local server to the website with Python's built-in server command:

```python
python3 -m http.server 3000 --directory example/local/
```

*example/local* represents the path to your website's *local/* directory


#### deploy

**deploy**
: performs the same website build process as **build** with the *public/* directory as the target, and deploys the website with the user configurable `deploy` command, defined in the website config file stored at $XDG_CONFIG_HOME/sitesync/ (the config file has the same name as the website directory)

#### User-confureable deploy command

Configure a website's deploy command by editing the deploy function stored in the $XDG_CONFIG_HOME/sitesync/ config file.
A website directory with the name *example/* will have a config file stored at $XDG_CONFIG_HOME/sitesync/example.

The deploy command doesn't deploy the website to anywhere until the user defines the command.

There are a few options the user can consider when configuring their deploy command:

##### Sync website to a server with rsync

You can sync the *public/* directory to a server using SiteSync's built in variables with the following command.

```bash
deploy() {
	rsync -az --delete "$site_dir"/public/ user@"$website":path/to/server/website/directory/
}
```

##### Push the site to a git repository

If you'd like to serve the website through a git repository that deploys a website through [Github Pages](https://pages.github.com/), [GitLab pages](https://docs.gitlab.com/ee/user/project/pages/), or [Netlify](https://www.netlify.com/) you can do something similar to the following:

```bash
deploy() {
	git add -A #stage all new and updated files
	git commit -m "generic commit message" #commit all files
	git push #push files to git and trigger deployment
}
```

## Directory structure

This is the basic directory structure that SiteSync creates with the **init** command, along with a config file saved in $XDG_CONFIG_HOME/sitesync (SiteSync creates this directory if it doesn't exist already.

```bash
example
├── assets
│   ├── styles.css
│   └── template.html
├── content
│   ├── blog
│   │   └── 2021-12-30_An_example_post.md
│   ├── blog.html
│   └── index.md
├── local
└── public
```

The config directory is structured like this, with a config file for each website that's been initialized with the **init** command:

```bash
$XDG_CONFIG_HOME/sitesync/
├── example
└── another_example_website
```
