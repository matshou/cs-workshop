#!/bin/bash
APP_DATA_PATH=$(echo $LOCALAPPDATA | sed 's/\\/\//g')
GAME_LOCAL_PATH="$APP_DATA_PATH/Colossal Order/Cities_Skylines"
SNAP_STAGE_PATH="$GAME_LOCAL_PATH/Snapshots"
ASSET_STAGE_PATH="$GAME_LOCAL_PATH/AssetStagingArea"
THUMB_EXPORT_PATH='thumb/export'
SNAPSHOT_EXPORT_PATH='snapshot/export'
ASSET_LIST_PATH="asset_list.txt"
declare DEST_PATH
if [[ -z "$1" ]]; then
	return
elif [ "$1" == "--verify-assets" ]; then
	ASSETS_PATH="$GAME_LOCAL_PATH/Addons/Assets"
	printf "Verifying game assets found in:\n%s\n" "$ASSETS_PATH"
	printf "Using list \"%s\"\n" "$ASSET_LIST_PATH"
	declare MISSING_ASSETS VERIFIED_ASSETS
	while IFS="" read -r p || [ -n "$p" ]
	do
		ASSET_FILE_NAME='fra_road_sign_'"$p"'.crp'
		if [ ! -f "$ASSETS_PATH/$ASSET_FILE_NAME" ]; then
			printf "Missing asset %s\n" "$ASSET_FILE_NAME"
			MISSING_ASSETS=$((MISSING_ASSETS+1))
		else
			VERIFIED_ASSETS=$((VERIFIED_ASSETS+1))
		fi
	done < "$ASSET_LIST_PATH"
	printf "Finished verifying game assets\n"
	printf "%d CRP assets found, %d missing\n" "$VERIFIED_ASSETS" "$MISSING_ASSETS"
elif [ "$1" == "--update-asset-stage" ]; then
	find "$SNAP_STAGE_PATH" -printf '%T+ %p\n' | sort -r | head  > data.tmp
	while IFS="" read -r p || [ -n "$p" ]
	do
		pattern="Snapshots\/[^\/]*$"
		if [[ "$p" =~ $pattern ]]; then
			pattern2='[[:space:]](.*\/([^\/]+))'
			[[ "$p" =~ $pattern2 ]]
			DEST_PATH="${BASH_REMATCH[1]}"
			if [[ ! -z "$DEST_PATH" ]]; then
				printf "Copying asset %s to %s\n" "$2" "${BASH_REMATCH[2]}"
				cp -a ./"$SNAPSHOT_EXPORT_PATH"'/'"$2"/. "$DEST_PATH"/
				break
			fi
		fi
	done < data.tmp
	find "$ASSET_STAGE_PATH" -printf '%T+ %p\n' | sort -r | head  > data.tmp
	while IFS="" read -r p || [ -n "$p" ]
	do
		pattern="AssetStagingArea\/[^\/]*$"
		if [[ "$p" =~ $pattern ]]; then
			pattern2='[[:space:]](.*\/([^\/]+))'
			[[ "$p" =~ $pattern2 ]]
			DEST_PATH="${BASH_REMATCH[1]}"
			if [[ ! -z "$DEST_PATH" ]]; then
				printf "Copying asset %s to %s\n" "$2" "${BASH_REMATCH[2]}"
				cp -a ./"$THUMB_EXPORT_PATH"'/'"$2"/. "$DEST_PATH"/
				break
			fi
		fi
	done < data.tmp
	rm -f data.tmp
fi
