@echo off
set /p id="Enter release name: "
7z a -mm=Deflate -mfb=258 -mpass=15 -r %cd%\Public\Release\%id%.zip %cd%\Workspace\Assets\*