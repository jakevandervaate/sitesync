#!/bin/sh

cd "$1/content/"

. ../config #source the config file

# reset the links on the blog page
cat "$blog_page" | sed '/^<p><a href/d' > tmp.html && cat tmp.html > "$blog_page"
rm tmp.html

# generate the new list of links to blog posts
for file in "$post_dir"/*; do
	ls -r "$post_dir"/ > posts.tmp
done

# format links properly for webpage
blog_links="$(for line in $(cat posts.tmp); do page_text="$(echo ""$line"" | sed -e 's/_/ /g' -e 's|blog\/||g' -e 's|.html||g')" && echo "$line" | sed "s|""$line""|<p><a href=blog/""$line"">""$page_text""</a></p>""|g"; done)"
echo "$blog_links" >> "$blog_page"
echo "Blog page generated"

rm posts.tmp

# generate rss file
#!/bin/sh
echo "<rss version=\"2.0\">
 <channel>
  <title>""$blog_title""</title>
   <link>""$website_link""</link>
   <description>""$blog_description""</description>" > "$rss_file"

for file in "$post_dir"/*; do
	blog_name="$(echo ""$file"" | sed -e 's/blog\/....-..-.._//g' -e 's/\.html//g' -e 's/_/ /g')"
	echo "     <item>
      <title>""$blog_name""</title>
      <link>""$website_link""/""$file""</link>
      <description>
<![CDATA[$content$(cat ""$file"")]]>
      </description>
     </item>" >> "$rss_file"
done

echo " </channel>
</rss>" >> "$rss_file"

echo """$rss_file"" generated"
mv "$rss_file" ../assets/
echo "Blog successfully generated for ""$website_link""!"
