#!/bin/bash
APP_DATA_PATH=$(echo $LOCALAPPDATA | sed 's/\\/\//g')
GAME_LOCAL_PATH="$APP_DATA_PATH/Colossal Order/Cities_Skylines"
IMPORT_PATH="$GAME_LOCAL_PATH/Addons/Import"
ASSET_LIST_PATH="../asset_list.txt"
MATERIALS_DIR="material"

printf "Generating texture materials...\n"
MATERIAL_MAP=('s' 'lod_s')
EXPORT_DIR='export'
while IFS="" read -r p || [ -n "$p" ]
do
	total=${#MATERIAL_MAP[*]}
	for (( i=0; i<=$(( $total -1 )); i++ ))
	do
		SRC="$MATERIALS_DIR"'/fra_road_sign_'"${MATERIAL_MAP[$i]}"'.png'
		DEST="$EXPORT_DIR"'/fra_road_sign_'"$p"'_'"${MATERIAL_MAP[$i]}"'.png'
		if test -f "$SRC"; then
			cp "$SRC" "$DEST"
			if ! test -f "$DEST"; then
				printf "Failed to generate %s\n" "$DEST"
			fi
		else
			printf "Skipping %s\n" "$SRC"
		fi
	done
done < "$ASSET_LIST_PATH"
printf "Finished generating textures\n"

printf "Copying texture files to imports...\n"
find "$EXPORT_DIR" -name '*.png' -exec cp {} "$IMPORT_PATH" \;

echo "Finished copying files!"
