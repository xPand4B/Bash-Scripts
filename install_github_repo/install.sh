#!/bin/bash
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

user=""
repo=""

read -p "Project Name [${green}${user}-${repo}${reset}]: " input
echo ""

if [ -z "$input" ];
    then
    git clone "https://github.com/${user}/${repo}" "${user}-${repo}"
    cd "${user}-${repo}"
else
    git clone "https://github.com/${user}/${repo}" ${input}
    cd ${input}
fi;

echo ""

cp .env.example .env
composer install --no-dev -a
composer dump-autoload -o
