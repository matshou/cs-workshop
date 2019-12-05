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
	for file in "$dir"/*_[acdins].png; do
		cp "$file" "$app_data/$local_dir"
	done
	for file in "$dir"/*.obj; do
		cp "$file" "$app_data/$local_dir"
	done
fi
n=$((n+1))
done < vehicle_assets.txt
