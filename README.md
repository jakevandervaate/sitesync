# SiteSync

This is my system for designing and editing basic, static websites. It uses a shell script, common HTML headers and footers, and separate "content" files to generate local (demo) and public (deployed) versions of websites.

This script has 2 basic commands, "demo" and "deploy". These scripts act on the different directories provided in this repo. 

## Directories

These repo features 4 directories and a config file. The 4 directories are "assets", "ccontent", "local", and "public". 

### Assets

This directory houses all the common files that the website can share, including the HTML header and footer for the website. 

The HTML header can be as basic as the minimum information included at the beginning of and HTML file (<!DOCTYPE html> ... ). You can also include any menus or title bars that you want to be present on every page. 

The HTML footer serves a similar function; it can be as basic as thae minimum information you need ( ... </html>), or have as many links or other elements as you please.

You can also add any other files you want to be placed in the root directory of your website (styles.css, robots.txt, humans.txt, favicon.ico, etc.). Everything in this directory, except for the header and footer, will be synced into the website's root directory when you run the sitesync.sh script.

### Content

This directory is where all of the "content" of the site's HTML files live. The content in these files is the information that you want to be unique to each page of your website. Files in this directory don't need the standard HTML file beginning and ending information (that's what the header and footer are for), but should be written in HTML.

This script currently supports the files in this content directory, and optionally once directory level below this. For example you could have your root directory with index.html, blog.html, and about.html, as well as a blog/ directory where you can store blog posts (the same rules apply as far as header and footer information go). 

### Local

When you run the command `path/to/sitesync.sh demo yourwebsite/`, the script will gather the various files from the content and assets directories, place the "content" files between the header.html and footer.html files, and places them in this local directory in the same structure that is present in the content directory. You can test this local version of your website in your web browser of choice to see how it looks and make changes.

### Public

When you run the command `path/to/sitesync.sh deploy yourwebsite/`, the script does the same this as the "demo" argument (it just places the files in this directory instead), and then mirrors this directory to the server that you identify in the config file. 

The separate "local" and "public" allow you to develop your website and make changes, while preserving the current files that are present on your server.

### Config

Place your server credentials in this file, inside the quotes for each variable. this config file allows the sitesync script to work on multiple websites that you may want to maintain and develop. 


## Usage 

Start the script by with the command for the script (`./sitesync.sh` if you're in the same directory as the script). 

The options for the second argument are either `demo`, or `deploy`. 

The third argument should be the path to the directory of your website, like `example/`. 

Here are examples of the whole command (assuming you are in the same directory as the script and the websites)

`./sitesync.sh demo example/` generates a local version of the website.

or 

`./sitesync.sh deploy example/` generates a public version, and syncs to your server.


## Installation

Clone this repository:

`git clone https://gitlab.com/jakevandervaate/sitesync.git`

cd into the newly cloned directory:

`cd sitesync/`

Make the script executable:

`sudo chmod +x ./sitesync.sh`

Now you are ready to use the script. This repo includes an example directory that you can test the script on. 

`./sitesync demo example/`

Now you can view the local version of this website. Navigate to the `example/local/` directory, and open the index.html file in your browser of choice (double click the file if you're using a GUI file explorer, or run `yourbrowser index.html` if you're using the command line). 


Now you can use this to create as many websites as you like. Just make sure that they all feature the basic directory structure that I've written aout here.
