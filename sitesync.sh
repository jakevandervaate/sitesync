#!/bin/sh

cd "$2" && site_dir="$(pwd)"
content="$site_dir/content"
assets="$site_dir/assets"

. "$site_dir"/config

case "$1" in
	"build") target_dir="local" ;;
	"deploy") target_dir="public" ;;
esac

rsync -a --delete "$content"/ "$target_dir"/

for file in $(find "$target_dir" -iname '*.html'); do
	page_content=$(cat "$file")
	name=$(echo "$file" | sed "s|""$content""/||g")
	cat "$assets"/header.html > "$name"
	echo "$page_content" >> "$name"
	cat "$assets"/footer.html >> "$name"
	page_title="$(grep -m 1 "<[Hh]1" ""$name"" | sed -e "s|<[Hh]1.*\">||g" -e "s|<[Hh]1>||g" -e "s|</[Hh]1>||g")"
	sed -i "s|{{ title }}|""$page_title""|g" "$name"
done

rsync -a "$assets"/* "$target_dir"/ --exclude *.html

sed -i "s|{{ root }}/||g" "$site_dir"/"$target_dir"/*.html && sed -i -e 's|{{ root }}|..|g' -e "s|f='sty|f='../sty|g" "$site_dir"/"$target_dir"/*/*.html 2>/dev/null || :

case "$1" in
	"build") : ;;
	"deploy") rsync -az --delete "$site_dir"/public/ "$user"@"$website":"$vpsdir"/ ;;
esac
