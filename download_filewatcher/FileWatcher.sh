#!/bin/bash
fileToWatch="/var/www/nextcloud/data/xPand/files/DownloadMe.txt"

while true; do
    sudo inotifywait -qm -e modify ${fileToWatch} | bash Download.sh
done
