#!/bin/bash
#=================================
# https://www.freecodecamp.org/news/manage-multiple-github-accounts-the-ssh-way-2dadc30ccaca/
#=================================

# Styles
#=================================
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

echo ""

# Check if default key file exists
#=================================
if [ -f ~/.ssh/id_rsa.pub ]; then
    echo "${red}SSH default key file already exists!${reset}"
else
    ssh-keygen -t rsa
    echo "${green}SSH key generated successfully!${reset}"
fi
echo ""

# Generate SSH config file
#=================================
if [ -f ~/.ssh/config ]; then
    echo "${red}SSH config file already exists!${reset}"
else
    touch ~/.ssh/config
    echo "${green}SSH config file created successfully!${reset}"
fi
echo ""

# Add to SSH config
#=================================
echo "Please enter some information regarding your git account:"
echo "========================================================="

# Git Email
gitEmail=$(git config user.email)
read -p "Email ${green}[$gitEmail]${reset}: " gitEmail
if [ -z "$gitEmail" ]; then
    gitEmail=$(git config user.email)
fi

# Git User
gitName=$(git config user.name | tr '[:upper:]' '[:lower:]' | sed -e 's/ /_/g')
read -p "Name ${green}[$gitName]${reset}: " gitName
if [ -z "$gitName" ]; then
    gitName=$(git config user.name | tr '[:upper:]' '[:lower:]' | sed -e 's/ /_/g')
else
    gitName=$(echo $gitName | tr '[:upper:]' '[:lower:]' | sed -e 's/ /_/g')
fi

# Git Host
read -p "Hostname ${green}[github.com]${reset} " gitHostname
gitHostname=${gitHostname:-"github.com"}
echo ""

# Generate new SSH key file
cd ~/.ssh
ssh-keygen -t rsa -C $gitEmail -f $gitName
# ssh-add $gitName

# Copy to config
echo >> ~/.ssh/config
echo "Host $gitHostname" >> ~/.ssh/config
echo "   HostName $gitHostname" >> ~/.ssh/config
echo "   User git" >> ~/.ssh/config
echo "   IdentityFile ~/.ssh/$gitName" >> ~/.ssh/config

echo ""
echo "${green}New Git User has successfully been added!${reset}"
echo ""
echo "${green}Key file :${reset} ~/.ssh/$gitName"
