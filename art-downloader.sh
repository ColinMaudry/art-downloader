#!/bin/bash

url="$1"

read -p "File name: " filename

echo "Available formats and languages:"
yt-dlp_linux "$url" -F

echo ""
read -p "Video format: " videoformat 
read -p "Audio format: " audioformat 

echo -e "\nDownloading format $videoformat and $audioformat for merging..."
yt-dlp_linux "$url" -f "$videoformat+$audioformat" -o "$filename.mp4"

read -p "Do you want subtitles? (y/n) " subtitles

if [[ subtitles == "n" ]]
then
    echo "Subtitles skipped"
else 
    yt-dlp_linux "$url" --write-subs -o "$filename"

    echo "Don't forget to clean the styles in the vtt and run the following command:"
    echo "ffmpeg -i file.vtt file.srt" -o "$filename"
    read -p "Press Enter when it's done (.vtt will be deleted)" deleted
fi

read -p "Do you want the files moved to movies dir? (y/n) " move
rm -f *.vtt

if [[ move == "n" ]]
then
    echo "Moving files skipped"
else
    mkdir ~/Videos/movies/$filename
    mv -v $filename.* ~/Videos/movies/$filename
fi

