#!/bin/bash
imports_file="imports_path.data"
path_data=$(head -1 $imports_file)
if [ ! -f "$imports_file" ] || [ "$path_data" == "" ]
then
	echo "ERROR: Missing imports path data."
	exit 1
fi
find Sunday -name '*_[acdins].png' -exec echo "Copying {}" \; -exec cp {} "$path_data" \;
find Sunday -name '*.obj' -exec echo "Copying {}" \; -exec cp {} "$path_data" \;
