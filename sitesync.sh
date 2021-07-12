#!/bin/sh

cd "$2" && wsd="$(pwd)" 
content="$wsd/content"
assets="$wsd/assets"

. "$wsd"/config

case "$1" in
	"build") dir="local" ;;
	"deploy") dir="public" ;;
esac

rsync -a --delete "$content"/ "$dir"/

for file in $(find "$dir" -iname '*.html'); do 
	pagecontent=$(cat "$file")
	name=$(echo "$file" | sed "s|""$content""/||g")
	cat "$assets"/header.html > "$name" && echo "$pagecontent" >> "$name" && cat "$assets"/footer.html >> "$name"
	TITLE="$(grep -m 1 "<[Hh]1" ""$name"" | sed -e "s|<[Hh]1.*\">||g" -e "s|<[Hh]1>||g" -e "s|</[Hh]1>||g")"
	sed -i "s|<\!-- TITLE -->|""$TITLE""|g" "$name"
done

rsync -a "$assets"/* "$dir"/ --exclude *.html

sed -i "s|PATHTOSOURCE/||g" "$wsd"/"$dir"/*.html && sed -i -e 's|PATHTOSOURCE|..|g' -e "s|f='sty|f='../sty|g" "$wsd"/"$dir"/*/*.html 2>/dev/null || :

case "$1" in
	build) : ;;
	deploy) rsync -az --delete "$wsd"/public/ "$user"@"$website":"$vpsdir"/ ;;
esac
