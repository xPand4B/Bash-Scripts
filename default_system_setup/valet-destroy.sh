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
#====================
brew update
brew upgrade
brew doctor
brew cleanup

# stop Valet
#=========================
echo ""
echo -e "${VP_GREEN}Stopping Valet...${VP_NONE}"
valet stop
sudo valet stop
composer global remove laravel/valet
composer global remove weprovide/valet-plus
brew services stop  --all

# Uninstall dnsmasq
#=========================
echo ""
echo -e "${VP_GREEN}Uninstalling dnsmasq...${VP_NONE}"
sudo launchctl unload homebrew.mxcl.dnsmasq.plist
brew uninstall dnsmasq --force
sudo rm -rf /usr/local/etc/dnsmasq.conf
sudo rm -rf /usr/local/Cellar/dnsmasq
sudo rm -rf /usr/local/opt/dnsmasq
sudo rm -rf /etc/resolver
sudo rm /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
sudo killall dnsmasq

# Uninstall nginx
#=========================
echo ""
echo -e "${VP_GREEN}Uninstalling nginx...${VP_NONE}"
sudo launchctl unload homebrew.mxcl.nginx.plist
brew uninstall nginx --force
sudo rm -rf /usr/local/etc/nginx
sudo rm -rf /usr/local/Cellar/nginx
sudo rm -rf /usr/local/opt/nginx
sudo rm /Library/LaunchDaemons/homebrew.mxcl.nginx.plist
sudo killall nginx
killall nginx

# Uninstall PHP74
#=========================
echo ""
echo -e "${VP_GREEN}Uninstalling PHP 7.4...${VP_NONE}"
sudo launchctl unload homebrew.mxcl.php74.plist
brew uninstall php74 php74-mcrypt php74-xdebug php74-opcache php74-apcu php74-geoip php74-intl php74-opcache n98-magerun n98-magerun2
brew uninstall valet-php@7.4 --force
sudo rm -rf /usr/local/etc/php
sudo rm -rf /usr/local/Cellar/php74*
sudo rm -rf /usr/local/opt/php74*
sudo rm -rf /usr/local/opt/php74
sudo rm -rf /usr/local/sbin/php*
sudo rm /Library/LaunchDaemons/homebrew.mxcl.php74.plist
sudo killall php-fpm

# Uninstall PHP73
#=========================
echo ""
echo -e "${VP_GREEN}Uninstalling PHP 7.3...${VP_NONE}"
sudo launchctl unload homebrew.mxcl.php73.plist
brew uninstall php73 php73-mcrypt php73-xdebug php73-opcache php73-apcu php73-geoip php73-intl php73-opcache n98-magerun n98-magerun2
brew uninstall valet-php@7.3 --force
sudo rm -rf /usr/local/etc/php
sudo rm -rf /usr/local/Cellar/php73*
sudo rm -rf /usr/local/opt/php73*
sudo rm -rf /usr/local/opt/php73
sudo rm -rf /usr/local/sbin/php*
sudo rm /Library/LaunchDaemons/homebrew.mxcl.php73.plist
sudo killall php-fpm

# Uninstall PHP72
#=========================
echo ""
echo -e "${VP_GREEN}Uninstalling PHP 7.2...${VP_NONE}"
sudo launchctl unload homebrew.mxcl.php72.plist
brew uninstall php72 php72-mcrypt php72-xdebug php72-opcache php72-apcu php72-geoip php72-intl php72-opcache n98-magerun n98-magerun2 --force
brew uninstall valet-php@7.2 --force
sudo rm -rf /usr/local/etc/php
sudo rm -rf /usr/local/Cellar/php72*
sudo rm -rf /usr/local/opt/php72*
sudo rm -rf /usr/local/opt/php72
sudo rm -rf /usr/local/sbin/php*
sudo rm /Library/LaunchDaemons/homebrew.mxcl.php72.plist
sudo killall php-fpm

# Uninstall PHP71
#=========================
echo ""
echo -e "${VP_GREEN}Uninstalling PHP 7.1...${VP_NONE}"
sudo launchctl unload homebrew.mxcl.php71.plist
brew uninstall php71 php71-mcrypt php71-xdebug php71-opcache php71-apcu php71-geoip php71-intl php71-opcache n98-magerun n98-magerun2 --force
brew uninstall valet-php@7.1 --force
sudo rm -rf /usr/local/etc/php
sudo rm -rf /usr/local/Cellar/php71*
sudo rm -rf /usr/local/opt/php71*
sudo rm -rf /usr/local/opt/php71
sudo rm -rf /usr/local/sbin/php*
sudo rm /Library/LaunchDaemons/homebrew.mxcl.php71.plist
sudo killall php-fpm

# Uninstall PHP70
#=========================
echo ""
echo -e "${VP_GREEN}Uninstalling PHP 7.0...${VP_NONE}"
sudo launchctl unload homebrew.mxcl.php70.plist
brew uninstall php70 php70-mcrypt php70-xdebug php70-opcache php70-apcu php70-geoip php70-intl php70-opcache n98-magerun n98-magerun2 --force
brew uninstall valet-php@7.0 --force
sudo rm -rf /usr/local/etc/php
sudo rm -rf /usr/local/Cellar/php70*
sudo rm -rf /usr/local/opt/php70*
sudo rm -rf /usr/local/opt/php70
sudo rm -rf /usr/local/sbin/php*
sudo rm /Library/LaunchDaemons/homebrew.mxcl.php70.plist
sudo killall php-fpm

# Uninstall PHP56
#=========================
echo ""
echo -e "${VP_GREEN}Uninstalling PHP 5.6...${VP_NONE}"
sudo launchctl unload homebrew.mxcl.php56.plist
brew uninstall php56 php56-mcrypt php56-xdebug php56-opcache php56-apcu php56-geoip php56-intl php56-opcache n98-magerun n98-magerun2 --force
brew uninstall valet-php@5.6 --force
sudo rm -rf /usr/local/etc/php
sudo rm -rf /usr/local/Cellar/php56*
sudo rm -rf /usr/local/opt/php56*
sudo rm -rf /usr/local/opt/php56
sudo rm -rf /usr/local/sbin/php*
sudo rm /Library/LaunchDaemons/homebrew.mxcl.php56.plist
sudo killall php-fpm

# Uninstall Node
#=========================
echo ""
echo -e "${VP_GREEN}Uninstalling Node...${VP_NONE}"
brwe unlink node --force
brwe unlink node@12 --force
brew uninstall node@12
brew uninstall node

# Uninstall ElasticSearch
#=========================
echo ""
echo -e "${VP_GREEN}Uninstalling ElasticSearch...${VP_NONE}"
launchctl list | grep elasticsearch
sudo launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch.plist
sudo launchctl remove homebrew.mxcl.elasticsearch
sudo pkill -f elasticsearch
brew uninstall elastic/tap/elasticsearch-full --force
brew untap elastic/tap
sudo rm -rf /usr/local/etc/elasticsearch
sudo rm -rf /usr/local/var/homebrew/linked/elasticsearch-full
sudo rm -rf /usr/local/var/lib/elasticsearch
sudo rm -rf /usr/local/var/log/elasticsearch


# Uninstall Mysql
#=========================
echo ""
echo -e "${VP_GREEN}Uninstalling MySQL...${VP_NONE}"
brew uninstall mysql --force
brew cleanup
sudo rm /usr/local/my.cnf
sudo rm /usr/local/etc/my.cnf
sudo rm /usr/local/mysql
sudo rm -rf /usr/local/var/mysql
sudo rm -rf /usr/local/mysql*
sudo rm ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
sudo rm -rf /Library/StartupItems/MySQLCOM
sudo rm -rf /Library/PreferencePanes/My*
sudo rm -rf /usr/local/Cellar/mysql
sudo rm -rf /usr/local/var/mysql

launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
rm ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist

rm -rf ~/Library/PreferencePanes/My*
sudo rm -rf /Library/Receipts/mysql*
sudo rm -rf /Library/Receipts/MySQL*
sudo rm -rf /private/var/db/receipts/*mysql*
sudo killall mysqld

# Uninstall Valet
#=========================
echo ""
echo -e "${VP_GREEN}Uninstalling Valet...${VP_NONE}"
brew uninstall mailhog --force
brew uninstall redis --force
brew uninstall wp-cli --force
brew untap henkrehorst/php
sudo launchctl unload homebrew.mxcl.mailhog.plist
sudo launchctl unload homebrew.mxcl.redis.plist
sudo rm /Library/LaunchDaemons/homebrew.mxcl.*
sudo killall mailhog
sudo killall redis

sudo rm -rf ~/.valet
sudo rm -rf ~/.composer/vendor/weprovide/
brew services stop  --all

# Remove composer from path
#=========================
# echo ""
# echo -e "${VP_GREEN}Removing composer from path...${VP_NONE}"
# before='export PATH="$PATH:$HOME/.composer/vendor/bin"'
# after=''
# sed -i  "s#${before}##g" ~/.bash_profile

# Prepare System
#=========================
brew update
brew upgrade
brew doctor
brew cleanup
brew prune

echo " "
echo -e "${VP_GREEN}${VP_BOLD}user brew services list to see if any services are running${VP_NONE}"
brew services list

echo " "
echo -e "${VP_GREEN}${VP_BOLD}use ps to see if any process's are running${VP_NONE}"
ps  aux | grep DesktopServer.app       | grep -v grep| head -1
ps  aux | grep "Local by Flywheel.app" | grep -v grep| head -1
ps  aux | grep -i "xamp"               | grep -v grep| head -1
ps  aux | grep -i "mamp"               | grep -v grep| head -1
ps  aux | grep dnsmasq                 | grep -v grep| head -1
ps  aux | grep nginx                   | grep -v grep| head -1
ps  aux | grep php                     | grep -v grep| head -1
ps  aux | grep node                    | grep -v grep| head -1
ps  aux | grep elasticsearch           | grep -v grep| head -1
ps  aux | grep mysql                   | grep -v grep| head -1

echo -e "${VP_RED}${VP_BOLD}REBOOT NOW BEFORE YOU RUN THE INSTALL${VP_NONE}"
