#!/bin/bash

url="$1"

echo "Available formats and languages:"
yt-dlp_linux "$url" -F

echo ""
read -p "Video format: " videoformat 
read -p "Audio format: " audioformat 

echo -e "\nDownloading format $videoformat and $audioformat for merging..."
yt-dlp_linux "$url" -f "$videoformat+$audioformat"

read -p "Do you want subtitles? (y/n) " subtitles

if [[ subtitles == "n" ]]
then
    exit
fi

yt-dlp_linux "$url" --write-subs

echo "Don't forget to clean the styles in the vtt and run the following command:"
echo "ffmpeg -i file.vtt file.srt"


