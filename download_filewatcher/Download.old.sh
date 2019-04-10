#!/bin/bash
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

downloadDir="/var/www/nextcloud/data/"
userDir=""

#while :
#do

read -p "Set your download link: " input

if [ ! -z "$input" ];
    then
    # Connect to VPN
    echo ""
    echo "${green}Establish VPN connection...${reset}"
    windscribe connect DE

    echo ""
    echo "${green}Downloading file...${reset}"

    # Download file
    sudo wget -P "${downloadDir}${userDir}" "${input}"

    # Assign downloaded file to user + group www-data
    sudo chown www-data:www-data -R "${downloadDir}${userDir}"
    echo ""

    # Disconnect from VPN
    windscribe disconnect

    # Rescan uploaded files
    echo ""
    sudo -u www-data php /var/www/nextcloud/occ files:scan --path="${userDir}"

    echo ""
else
    echo "${red}Nothing to download.${reset}"
    echo ""
fi;

#done
