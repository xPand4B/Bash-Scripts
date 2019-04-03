#!/bin/bash
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

while :
do

echo ""
echo "[1] Install Standard Packages"
echo -e "\tSSH-Pass, ARC Theme, Pocillo Icons, PulseAudio Volume Control, Tweaks"
echo ""
echo "[2] Fix Login Screen showing on wrong monitor"
echo -e "\tChanges Login screen from second to main monitor"
echo ""
echo "[3] Install LAMP Stack"
echo -e "\tApache2, MySQL, PHP, PHPMyAdmin"
echo ""
echo "[4] Install WebDev Dependencies"
echo -e "\tGit, Composer, nodejs, npm"

echo ""
read -p "Select your option [${green}1${reset}/${green}2${reset}/${green}3${reset}/${green}4${reset}]: " input

# Install Standard Packages
if [ $input -eq 1 ]; then
	echo ""
	echo "${green}Installing standard packages...${reset}"
	echo ""
	sudo apt update -y
	sudo apt upgrade -y
	sudo apt autoremove --purge -y

	# SSH-Pass
	echo ""
	echo "${green}Installing SSH-Pass...${reset}"
	echo ""
	sudo apt install sshpass

	# ARC Theme
	echo ""
	echo "${green}Installing ARC Theme...${reset}"
	echo ""
	sudo apt-get install arc-theme -y

	# Pocillo Icon Pack
	echo ""
	echo "${green}Installing Pocillo Icon Pack...${reset}"
	echo ""
	sudo apt install pocillo-icon-theme -y

	# PulseAudio Volume Control
	echo ""
	echo "${green}Installing PulseAudio Volume Control...${reset}"
	echo ""
	sudo apt install pulseaudio -y
	sudo apt install pavucontrol -y

	sudo apt update -y

	# GNOME Tweaks
	echo ""
	echo "${green}Installing gnome-Tweaks...${reset}"
	echo ""
	sudo apt install gnome-tweaks -y

	# Menulibre
	echo ""
	echo "${green}Installing Menulibre...${reset}"
	echo ""
	sudo apt install menulibre -y

	# Set default audio input/output

	echo ""
	echo "${green}To update default audio input/output follow these steps.${reset}"
	echo ""
	echo "${green}Sinks${reset}"
	pactl list short sinks
	echo ""
	echo "${green}Sources${reset}"
	pactl list short sources
	echo ""
	echo -e "\t$ sudo nano /etc/pulse/default.pa"
	echo ""
	echo -e "\tUncomment ${green}set-default-sink${reset} ${red}output${reset} and ${green}set-default-source${reset} ${red}input${reset}."
	echo ""
	echo -e "\tReplace ${red}input${reset}/${red}output${reset} with the number you want from the command befor."
	echo ""
	# Show drive uuid's
	#sudo blkid
fi

# Fix Login Screen showing on wrong monitor
if [ $input -eq 2 ]; then
	sudo apt update -y
	sudo apt upgrade -y
	sudo apt autoremove --purge -y

	# https://askubuntu.com/questions/1043337/ubuntu-18-04-login-screen-display-settings
	sudo cp ~/.config/monitors.xml ~gdm/.config/monitors.xml
	sudo chown gdm:gdm ~gdm/.config/monitors.xml

	# https://www.cyberciti.biz/faq/how-to-use-sed-to-find-and-replace-text-in-files-in-linux-unix-shell/
	sudo sed -i 's/#WaylandEnable=false/WaylandEnable=false/g' /etc/gdm3/custom.conf

	echo ""
	echo "${green}Login Screen should now be on the correct monitor.${reset}"
	echo ""
	echo "${green}You need to restart in order to apply the changes.${reset}"
	echo ""
fi

# Install LAMP Stack
if [ $input -eq 3 ]; then
	echo ""
	echo "${green}Installing LAMP Stack...${reset}"
	echo ""
	sudo apt update -y
	sudo apt upgrade -y
	sudo apt autoremove --purge -y

	# PHP Repository
	echo ""
	echo "${green}Installing PHP Repository...${reset}"
	echo ""
	sudo add-apt-repository ppa:ondrej/php

	echo ""
	echo "${green}Installing PHP packages...${reset}"
	echo ""
	# Packages
	while read -r p ; do sudo apt-get install -y $p ; done < <(cat << "EOF"
	apache2
	apache2-utils
	mysql-server
	curl
	libapache2-mod-php
	php
	php-common
	php-xml
	php-gd
	php7.2-opcache
	php-mysql
	php7.2-mysql
	php-gettext
	php-cli
	php7.2-pdo-sqlite
	php-curl
	php-json
	php-mbstring
	php7.2-mbstring
	php-gettext
	php-readline
	php-mcrypt
EOF
)
    sudo apt install phpmyadmin

	sudo a2enmod rewrite
	sudo a2enmod php7.3
	sudo phpenmod mcrypt
	sudo phpenmod mbstring
	sudo systemctl restart apache2
	sudo apache2ctl configtest

	# MYSQL Setup
	echo ""
	echo "${green}MySQL Setup...${reset}"
	echo ""
	sudo mysql_secure_installation

	sudo apt autoremove --purge -y

	echo ""
	echo "${green}Allow incoming traffic for this profile.${reset}"
	echo ""
	sudo ufw allow in "Apache Full"

	echo ""
	echo ""
	echo "${green}Type following text to create a new mysql user.${reset}"
	echo ""
	echo -e "\t$ sudo mysql -u root"
	echo -e "\tmysql> CREATE NEW USER '${red}USERNAME${reset}'@'localhost' IDENTIFIED BY '${red}PASSWORD${reset}';"
	echo -e "\tmysql> GRANT ALL PRIVILEGES ON *.* '${red}USERNAME${reset}'@'localhost' WITH GRANT OPTION;"

	echo ""
	echo "${green}If you want a user without a password you need to uncomment the following text.${reset}"
	echo ""
	echo -e "\tInside ${red}/etc/phpmyadmin/config.inc.php${reset} search for ${red}AllowNoPassword${reset} and uncomment this line."
	echo ""

	echo ""
	echo "${green}LAMP Stack has been installed.${reset}"
	echo ""
fi

# Install WebDev Dependencies
if [ $input -eq 4 ]; then
	echo ""
	echo "${green}Installing WebDev packages...${reset}"
	echo ""
	sudo apt update -y
	sudo apt upgrade -y
	sudo apt autoremove --purge

	curl -sL https://deb.nodesource.com/setup_8.x | sudo bash -

	# git
	echo ""
	echo "${green}Installing git...${reset}"
	echo ""
	sudo apt install git -y

	# composer
	echo ""
	echo "${green}Installing composer....${reset}"
	echo ""
	sudo apt-get install composer -y

	# nodejs
	echo ""
	echo "${green}Installing nodejs...${reset}"
	echo ""
	sudo apt-get install nodejs -y

	# npm
	echo ""
	echo "${green}Installing npm...${reset}"
	echo ""
	sudo apt-get install npm -y

	sudo apt-get autoremove --purge

	echo ""
	echo "${green}Git${reset}"
	git --version

	echo ""
	echo "${green}Composer${reset}"
	composer -V

	echo ""
	echo "${green}nodejs${reset}"
	nodejs -v

	echo ""
	echo "${green}npm${reset}"
	npm -v

	echo ""
	echo "${green}WebDev packages has been installed.${reset}"
	echo ""
fi

done
