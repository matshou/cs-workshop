#!/bin/bash
local_dir="Local/Colossal Order/Cities_Skylines/Addons/Import/"
app_data=$(head -1 app_data.meta)
n=1
if [ -z "$app_data" ] || [ $app_data == "" ]
then
	echo "Unable to find app data meta info."
	exit 1
fi
while read dir; do
if [ -d "$dir" ]
then
	target=$app_data/$local_dir
	for file in "$dir"/*_[acdins].png; do
		echo "Copying $file..."
		cp "$file" "$target"
	done
	for file in "$dir"/*.obj; do
		echo "Copying $file..."
		cp "$file" "$target"
	done
fi
n=$((n+1))
done < vehicle_assets.txt
