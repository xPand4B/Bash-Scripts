#!/bin/bash
echo "What's your new vhost name?"
read input
echo ""

indexTemplate="/home/xpand/indexTemplate.php"
readmeTemplate="/home/xpand/readmeTemplate.md"
apacheConfTemplate='/var/www/vhosts/vhost.conf.txt'
newApacheConf="/etc/apache2/sites-available/${input}.conf"
vHostDirectory="/var/www/vhosts"

# Create vHost directory
sudo mkdir "${vHostDirectory}/${input}"
sudo chown www-data:www-data "${vHostDirectory}/${input}"
echo "vHost Directory: ${vHostDirectory}/${input}"

# Create apache virtual host
sudo cp "${apacheConfTemplate}" "${newApacheConf}"

# Loop through new config file
n=1
while read line; do
        # reading each line
        search=INPUT
        if [ "${line/$search}" != "$line" ] ; then
                sudo sed -i "s/${search}/${input}/g" $newApacheConf
        fi
        n=$((n+1))

done < $newApacheConf

sudo a2ensite "${input}.conf"
sudo systemctl reload apache2

# Create default index.php file
sudo cp "${indexTemplate}" "${vHostDirectory}/${input}/index.php"
sudo chown www-data:www-data "${vHostDirectory}/${input}/index.php"

# Create default README.md file
sudo cp "${readmeTemplate}" "${vHostDirectory}/${input}/README.md"
# Loop through new README.md file
n=1
while read line; do
        # reading each line
        search=INPUT
        if [ "${line/$search}" != "$line" ] ; then
                sudo sed -i "s/${search}/${input}/g" "${vHostDirectory}/${input}/README.md"
        fi
        n=$((n+1))

done < "${vHostDirectory}/${input}/README.md"
sudo chown www-data:www-data "${vHostDirectory}/${input}/README.md"

echo ""
echo "Your vHost has been created successfully."