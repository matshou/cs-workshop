find export -maxdepth 1 -iregex '.*\.\(png\)' -printf '%f\n' > data.tmp
printf "Generating thumbnail files...\n"
declare GENERATED
while IFS="" read -r p || [ -n "$p" ]
do
	pattern="^([^\_]+)\_([^.]+)(\.[a-zA-Z]+)"
	if [[ "$p" =~ $pattern ]]; then
		DIR_PATH='export/'"${BASH_REMATCH[1]}"
		ASSET_NAME="${BASH_REMATCH[2]}"
		FILE_EXT="${BASH_REMATCH[3]}"
		DEST_PATH="$DIR_PATH"'/'"$ASSET_NAME""$FILE_EXT"
		SRC_PATH='export/'"$p"

		TOOLTIP='asset_tooltip.png'
		CP_PATH="$DIR_PATH"'/'"$TOOLTIP"
		mkdir -p "$DIR_PATH" && cp "$TOOLTIP" "$CP_PATH"
		mv "$SRC_PATH" "$DEST_PATH"
		GENERATED=$((GENERATED+1))
	fi
done < data.tmp
rm -f data.tmp
printf "Generated %d files\n" "$GENERATED"
