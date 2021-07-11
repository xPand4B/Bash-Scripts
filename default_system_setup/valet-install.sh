#!/bin/bash

#styles
VP_NONE='\033[00m'
VP_RED='\033[01;31m'
VP_GREEN='\033[01;32m'
VP_YELLOW='\033[01;33m'
VP_PURPLE='\033[01;35m'
VP_CYAN='\033[01;36m'
VP_WHITE='\033[01;37m'
VP_BOLD='\033[1m'
VP_UNDERLINE='\033[4m'

# clear the screen
clear

# cache sudo password so it will only need to be entered once.
echo -e "${VP_RED}${VP_BOLD}You may be asked to enter your password twice….${VP_NONE}"
sudo -v

# Prepare System
#=========================
brew update
brew upgrade
brew doctor
brew cleanup

# Installing Composer
#=========================
echo ""
echo -e "${VP_GREEN}Installing composer...${VP_NONE}"
brew install composer

# Installing PHP
#=========================
echo ""
echo -e "${VP_GREEN}Installing PHP...${VP_NONE}"
brew tap henkrehorst/php
brew install valet-php@7.3 --build-from-source
brew install valet-php@7.4 --build-from-source
brew install valet-php@8.0 --build-from-source
brew link valet-php@7.4 --force --overwrite

# Installing ElasticSearch
#=========================
echo ""
echo -e "${VP_GREEN}Installing ElasticSearch...${VP_NONE}"
# https://www.elastic.co/guide/en/elasticsearch/reference/current/brew.html
brew tap elastic/tap
brew install elastic/tap/elasticsearch-full

# Installing Valet+
#=========================
echo ""
echo -e "${VP_GREEN}Installing Valet+...${VP_NONE}"
composer global require weprovide/valet-plus
# valet fix
valet install
# valet install --with-mariadb
# valet elasticsearch install
valet use 7.4
# valet xdebug off
# valet redis off
# valet mailhog off

# Install node
#=========================
echo ""
echo -e "${VP_GREEN}Installing node...${VP_NONE}"
brew install node
brew install node@12
brew unlink node
brew link node@12 --force --overwrite

# Prepare System
#=========================
brew update
brew upgrade
brew doctor
brew cleanup


# Create MySQL User
#=========================
echo ""
echo -e "${VP_GREEN}Creating MySQL User...${VP_NONE}"
mysql --user='root' --password='root' --execute="CREATE USER 'app'@'localhost' IDENTIFIED BY 'app'; GRANT ALL PRIVILEGES ON *.* TO 'app'@'localhost' WITH GRANT OPTION;"

# Ping 
#=========================
echo ""
echo -e "${VP_GREEN}Ping Testing...${VP_NONE}"
ping -c1 foobar.test

echo " "
echo -e "${VP_GREEN}${VP_BOLD}Running brew services...${VP_NONE}"
brew services list

echo ""
echo -e "${VP_RED}${VP_BOLD}⚠️ REBOOT NOW BEFORE USING VALET PLUS ⚠️${VP_NONE}"