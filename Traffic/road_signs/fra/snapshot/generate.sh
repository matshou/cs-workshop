find export -maxdepth 1 -iregex '.*\.\(png\)' -printf '%f\n' > data.tmp
printf "Generating snapshot files...\n"
declare GENERATED
while IFS="" read -r p || [ -n "$p" ]
do
	pattern="^[^\.]+"
	if [[ "$p" =~ $pattern ]]; then
		ASSET_NAME="${BASH_REMATCH[0]}"
		SRC_DIR='export/'"$p"
		DEST_DIR='export/'"$ASSET_NAME"
		TARGET_PATH="$DEST_DIR"'/snapshot.png'
		mkdir -p "$DEST_DIR"
		mv "$SRC_DIR" "$TARGET_PATH"
		cp "tooltip.png" "$DEST_DIR"
		SRC_DIR='../thumb/export/'"$ASSET_NAME"'/asset_thumb.png'
		if [ -f "$SRC_DIR" ]; then
			cp "$SRC_DIR" "$DEST_DIR"'/thumbnail.png'
		else
			printf "Warning: Unable to find thumbnail for %s\n%s\n" "$p" "$SRC_DIR"
		fi
		GENERATED=$((GENERATED+1))
	fi
done < data.tmp
rm -f data.tmp
printf "Generated %d files\n" "$GENERATED"
