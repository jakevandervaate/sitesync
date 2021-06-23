#!/bin/sh

cd "$1/content/"

. ../config #source the config file
cat "$blog_page" | sed '/^<p><a href/d' > tmp.html && cat tmp.html > "$blog_page"

rm tmp.html

for file in "$post_dir"/*; do
	ls -r "$post_dir"/ > posts
done

blog_links="$(for line in $(cat posts); do page_text="$(echo ""$line"" | sed -e 's/_/ /g' -e 's|blog\/||g' -e 's|.html||g')" && echo "$line" | sed "s|""$line""|<p><a href=blog/""$line"">""$page_text""</a></p>""|g"; done)"

echo "$blog_links" >> "$blog_page"

echo "Blog page generated"

rm posts

echo '<rss version="2.0">' > "$rss_file"
echo "" >> "$rss_file"

echo "<channel>" >> "$rss_file"
echo " <title>""$blog_title""</title>" >> "$rss_file"
echo "  <link>""$website_link""</link>" >> "$rss_file"
echo "  <description>""$blog_description""</description>" >> "$rss_file"
for file in "$post_dir"/*; do
	blog_name="$(echo ""$file"" | sed -e 's/blog\/....-..-.._//g' -e 's/\.html//g' -e 's/_/ /g')"
	echo '  <item>' >> "$rss_file"
	echo "    <title>""$blog_name""</title>" >> "$rss_file"
	echo "    <link>""$website_link""/""$file""</link>" >> "$rss_file"
	echo '    <description>' >> "$rss_file"
	echo "<![CDATA[$content$(cat ""$file"")]]>" >> "$rss_file"
	echo '    </description>' >> "$rss_file"
	echo '   </item>' >> "$rss_file"
done

echo '</channel>' >> "$rss_file"
echo '</rss>' >> "$rss_file"
echo """$rss_file"" generated"
mv "$rss_file" ../assets/
echo "Blog successfully generated for ""$website_link""!"
