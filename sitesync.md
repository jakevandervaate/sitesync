% MS(1) ms 1.0.3
% Jake VanderVaate
% December 2021

# NAME
sitesync - a simple static-site generation shell script

# SYNOPSIS
**sitesync** [*OPTION*] [*TARGET*]

# DESCRIPTION
**sitesync** compiles a website's page content into a fully-functioning webpages based off of a user supplied template.

sitesync requires a the folder/file structure that the **init** arugment provides when creating a new website directory

# OPTIONS
**build**
: builds a local version of the website, saved in the website's "local" folder

**deploy**
: builds the website into the "public" directory where the directory is then mirrored to wherever it is served from. This can be synced to a VPS, or pushed to a Git provider that serves from the site's repository.

**init**
: creates a new website directory with the name of the argument following **init**. The directory contains "assets", "local", "public", and "content" directories.

# EXAMPLES

**sitesync init example**
: Creates a website directory titled "example" in the current directory, with the following directories and files:
* assets/
  - styles.css
  - template.html
* content/
  - index.md
  - blog.html
  - blog/
    * example.html
* local/
* public/

**sitesync build path/to/example**
: Builds a local version of the website (with the proper directory structure) into the "local" folder. If the website features no Javascript (is just HTML, CSS, and local files) the local version of the site can be viewed at *file:///absolute/path/to/local/folder/file.html*.

**sitesync deploy path/to/example**
: the deploy command builds the website into the "public" directory and then can mirror the website to where it is served with the deploy command defined in the "$XDG_CONFIG_HOME"/sitesync/example" file.

# EXIT VALUES
**0**
: Success

# BUGS
This script requires the basic directory structure provided by the **init** command.
The script will also not correct absolute file paths to the root of the site deeper than 3 directories from the site root (e.g. root/subdir/anothersubdir/file.html would work).

# COPYRIGHT
This is free software provided under the GPLv3 license. You are free to change and distribute this software, so long as it remains free software. There is no warranty, to the extent permitted by law.
