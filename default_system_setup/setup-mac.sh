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
#=================================
echo ""
echo -e "${green}Installing ZSH...${reset}"
brew update

# https://sourabhbajaj.com/mac-setup/iTerm/zsh.html
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

brew unlink php
brew unlink php@7.4
brew unlink php@8.0
brew link php@8.0 --force --overwrite
echo -e "${green}PHP sucessfully installed!${reset}"

# Install Node
#=================================
echo ""
echo -e "${green}Installing Node...${reset}"
brew update

brew install node

echo -e "${green}Node sucessfully installed!${reset}"

# Install Composer
#=================================
echo ""
echo -e "${green}Installing Composer...${reset}"
brew update
brew install composer

echo -e "${green}Composer successfully installed${reset}"

# Install CLI Helper
#=================================
echo ""
echo -e "${green}Installing CLI Helper...${reset}"
brew update

brew install symfony-cli/tap/symfony-cli
composer global require laravel/installer

echo -e "${green}CLI Helper successfully installed${reset}"

# Install Valet
#=================================
echo ""
echo -e "${green}Installing Laravel Valet...${reset}"
brew update
composer global require laravel/valet
valet install
valet use php@8.0 --force
echo -e "${green}Laravel Valet successfully installed!${reset}"

# Creating directories
#=================================
echo ""
echo -e "${green}Creating directories...${reset}"
mkdir $developmentDir
mkdir $developmentDir/00-Projects
mkdir $developmentDir/Symfony
mkdir $developmentDir/sw5
mkdir $developmentDir/sw6
mkdir $developmentDir/sw6_testing
ls -la $developmentDir
echo -e "${green}Directories successfully created!${reset}"

# Cloning Valet Dashboard
#=================================
echo ""
echo -e "${green}Cloning xPand4B/ValetDashboard...${reset}"
cd 00-Projects
git clone git@github.com:xPand4B/ValetDashboard.git
cd ..
echo -e "${green}xPand4B/ValetDashboard successfully cloned...${reset}"

# Parking Directories to Valet
#=================================
echo ""
echo -e "${green}Linking directories to Valet...${reset}"
cd 00-Projects && valet park && cd ..
cd sw6_testing && valet park && cd ..
cd Symfony && valet park && cd ..
echo -e "${green}Directories successfully linked!${reset}"


# Open Valet Dashboard
#=================================
open http://valetdashboard.test