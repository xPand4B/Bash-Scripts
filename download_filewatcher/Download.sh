#!/bin/bash
downloadDir="/var/www/nextcloud/data/"

downloadList="${downloadDir}"
userDir=""

links=$(sudo cat ${downloadList})

if [ ! -z $links ]; then
        # Connect to VPN
        windscribe connect DE

        tempLinks=$links

        for link in $links
        do
                tempLinks=${tempLinks/$link/""}

                # Download file
                sudo wget -P "${downloadDir}${userDir}" "${link//[$'\t\r\n']}"
                truncate -s 0 "${downloadList}"

                for tempLink in ${tempLinks}
                do
                        echo $tempLink >> ${downloadList}
                done

        done

        # Assign downloaded file to user + group www-data
        sudo chown www-data:www-data -R "${downloadDir}${userDir}"

        # Disconnect from VPN
        windscribe disconnect

        # Rescan uploaded files
        sudo -u www-data php /var/www/nextcloud/occ files:scan --path="${userDir}"
fi
