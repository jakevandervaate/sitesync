#!/bin/sh

cd "$2" && wsd="$(pwd)" 
content="$wsd/content"
assets="$wsd/assets"

. "$wsd"/config

case "$1" in
	"demo") dir="local" ;;
	"deploy") dir="public" ;;
esac

rsync -a --delete "$content"/ "$dir"/

for file in $(find "$dir" -iname '*.html'); do 
	pagecontent=$(cat "$file")
	name=$(echo "$file" | sed "s|""$content""/||g")
	cat "$assets"/header.html > "$name" && echo "$pagecontent" >> "$name" && cat "$assets"/footer.html >> "$name"
done

rsync -a "$assets"/* "$dir"/ --exclude *.html

sed -i "s|PATHTOSOURCE/||g" "$wsd"/"$dir"/*.html && sed -i -e 's|PATHTOSOURCE|..|g' -e "s|f='sty|f='../sty|g" "$wsd"/"$dir"/*/*.html 2>/dev/null || :

case "$1" in
	demo) : ;;
	deploy) rsync -az --delete "$wsd"/public/ "$user"@"$website":"$vpsdir"/ ;;
esac
