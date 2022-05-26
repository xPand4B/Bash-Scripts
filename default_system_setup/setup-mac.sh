#!/bin/bash

# Styles
#=================================
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

# Initial setup
#=================================
read -p "Enter your preferred dev directory ${green}[~/Development]${reset}: " developmentDir
developmentDir=${developmentDir:-"~/Development"}
echo ""

# Install Brew
#=================================
echo ""
echo -e "${green}Installing Homebrew...${reset}"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo -e "${green}Homebrew sucessfully installed!${reset}"

# Installing git
#=================================
echo ""
echo -e "${green}Installing Git...${reset}"
brew update
brew install git
echo -e "${green}Git successfully installed!${reset}"

# Install ZSH
# https://sourabhbajaj.com/mac-setup/iTerm/zsh.html
#=================================
echo ""
echo -e "${green}Installing ZSH...${reset}"
brew update
brew install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# chsh -s $(which zsh)

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
source ~/.zshrc

echo -e "${green}ZSH sucessfully installed!${reset}"
echo ""
echo -e "${green}Read more about ZSH here: https://sourabhbajaj.com/mac-setup/iTerm/zsh.html${reset}"
echo ""

# Install PHP
#=================================
echo ""
echo -e "${green}Installing PHP...${reset}"
brew update

brew install php@7.4
brew install php@8.0
brew install php@8.1

brew unlink php
brew unlink php@7.4
brew unlink php@8.0
brew unlink php@8.1

brew link php@8.1 --force --overwrite
echo -e "${green}PHP sucessfully installed!${reset}"

# Install Composer
#=================================
echo ""
echo -e "${green}Installing Composer...${reset}"
brew update
brew install composer
echo -e "${green}Composer successfully installed${reset}"

# Install Laravel Valet
# https://laravel.com/docs/8.x/valet
#=================================
echo ""
echo -e "${green}Installing Laravel Valet...${reset}"
brew update
composer global require laravel/valet
valet install
valet use php@8.1 --force
echo -e "${green}Laravel Valet successfully installed!${reset}"

# Install PHP Monitor
# https://github.com/nicoverbruggen/phpmon
#=================================
echo ""
echo -e "${green}Installing PHP Monitor...${reset}"
brew update
brew tap nicoverbruggen/homebrew-cask
brew install --cask phpmon
echo -e "${green}PHP Monitor successfully installed!${reset}"

# Install CLI Helper
#=================================
echo ""
echo -e "${green}Installing CLI Helper...${reset}"
composer global require laravel/installer
echo -e "${green}CLI Helper successfully installed${reset}"

# Install Node
#=================================
echo ""
echo -e "${green}Installing Node...${reset}"
brew update
brew install node
echo -e "${green}Node sucessfully installed!${reset}"

# Creating directories
#=================================
echo ""
echo -e "${green}Creating directories...${reset}"
mkdir -p $developmentDir/00-Projects
mkdir -p $developmentDir/Laravel
mkdir -p $developmentDir/byte5
echo -e "${green}Directories successfully created!${reset}"

# Cloning Valet Dashboard
#=================================
echo ""
echo -e "${green}Cloning xPand4B/ValetDashboard...${reset}"
git clone git@github.com:xPand4B/ValetDashboard.git $developmentDir/00-Projects/ValetDashboard
echo -e "${green}xPand4B/ValetDashboard successfully cloned...${reset}"

# Parking Directories to Valet
#=================================
echo ""
echo -e "${green}Linking directories to Valet...${reset}"
cd $developmentDir/00-Projects && valet park
cd $developmentDir/Laravel && valet park
cd $developmentDir/byte5 && valet park
echo -e "${green}Directories successfully linked!${reset}"


# Open Valet Dashboard
#=================================
open http://valetdashboard.test
