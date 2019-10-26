#!/bin/bash
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

while :
do

echo ""
echo "[1] Install Standard Packages"
echo -e "\tHomebrew, PHP, Apache, MySQL"
echo ""
echo "[2] Install WebDev Dependencies"
echo -e "\tGit, Composer, nodejs, Laravel, ..."
echo ""
echo "[3] Change Apache config"
echo -e "\thttp://localhost = /Users/{user}/Development"
echo ""
echo "[4] Add mysql user 'app'@'localhost'"
echo ""
echo "[5] Re-write '.bash_profile'"
echo -e "\tAdd aliases and exports"

echo ""
read -p "Select your option [ ${green}0(all)${reset} / ${green}1${reset} / ${green}2${reset} / ${green}3${reset} / ${green}4${reset} ]: " input

# if mysql: add user -u app -p app

# Install homebrew
if [ $input -eq 0 ] || [ $input -eq 1 ]|| [ $input -eq 2 ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install Standard Packages
if [ $input -eq 1 ] || [ $input -eq 0 ]; then
    # PHP
    brew install php@7.2
    brew unlink php && brew link php@7.2 --force
    ​
    # Apache
    brew install httpd

    # PSH dependencies
    brew install ant

    # MySQL
    brew install mysql@5.7

    echo ""
    echo "PHP:"
    php -v

    echo ""
    echo "Apache:"
    httpd -v
fi

# Install WebDev Dependencies
if [ $input -eq 2 ] || [ $input -eq 0 ]; then
    # Composer
    brew install composer

    # node.js
    brew install node

    # git
    brew install git

    # Laravel
    composer global require laravel/installer

    echo ""
	echo "${green}Everything has successfully been installed.${reset}"
	echo ""

    echo ""
    echo "composer:"
    composer -v

    echo ""
    echo "node.js"
    node -v

    echo ""
    echo "npm:"
    npm -v

    echo ""
    echo "Laravel:"
    laravel -V
fi

# Change Apache config
if [ $input -eq 3 ] || [ $input -eq 0 ]; then
    user=$USER
    
    apacheConfig='/etc/apache2/httpd.conf'
    apacheVhostConfig='/etc/apache2/extra/httpd-vhost.conf'

    httpdConfig='/usr/local/etc/httpd/httpd.conf'
    httpdVhostCOnfig='/usr/local/etc/httpd/extra/httpd-vhost.conf'

    userConfig='/usr/local/etc/httpd/extra/httpd-userdir.conf'
fi

# Re-write .bash_profile
if [ $input -eq 4 ] || [ $input -eq 0 ]; then
    touch ~/.bash_profile

    echo '#***************************' >> ~/.bash_profile
    echo '#***** Exports *************' >> ~/.bash_profile
    echo '#***************************' >> ~/.bash_profile
    echo 'export PATH="/usr/local/sbin:$PATH"' >> ~/.bash_profile
    echo '---' >> ~/.bash_profile
    echo 'export PATH="/usr/local/mysql/bin:$PATH"' >> ~/.bash_profile
    echo 'export PATH="~/.composer/vendor/bin:$PATH"' >> ~/.bash_profile
    echo 'export PATH="/usr/local/opt/php@7.2/bin:$PATH"' >> ~/.bash_profile
    echo 'export PATH="/usr/local/opt/php@7.2/sbin:$PATH"' >> ~/.bash_profile
    echo '---' >> ~/.bash_profile
    echo 'export LDFLAGS="-L/usr/local/opt/php@7.2/lib"' >> ~/.bash_profile
    echo '---' >> ~/.bash_profile
    echo 'export CPPFLAGS="-I/usr/local/opt/php@7.2/include"' >> ~/.bash_profile
    echo '---' >> ~/.bash_profile
    echo '' >> ~/.bash_profile

    echo '#***************************' >> ~/.bash_profile
    echo '#***** Alias ***************' >> ~/.bash_profile
    echo '#***************************' >> ~/.bash_profile
    echo 'alias dev="cd ~/Development"' >> ~/.bash_profile
    echo 'alias udemy="cd ~/Nextcloud/Private/Webdev/Udemy"' >> ~/.bash_profile
    echo 'alias github="cd ~/Nextcloud/Private/Webdev/Github"' >> ~/.bash_profile
    echo '---' >> ~/.bash_profile
    echo 'alias ll="ls -la"' >> ~/.bash_profile
    echo '---' >> ~/.bash_profile
    echo 'alias psh="./psh.phar"' >> ~/.bash_profile
    echo '---' >> ~/.bash_profile
    echo 'alias pu="clear && vendor/bin/phpunit"' >> ~/.bash_profile
    echo 'alias pf="clear && vendor/bin/phpunit --filter"' >> ~/.bash_profile
    echo '---' >> ~/.bash_profile
    echo 'alias pa="clear && php artisan"' >> ~/.bash_profile
    echo '' >> ~/.bash_profile

    source ~/.bash_profile
fi

done
