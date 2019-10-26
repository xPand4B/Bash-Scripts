#!/bin/bash

links=$(cat "dlList.txt")

tempLinks=$links

for link in $links
do
   #echo $tempLinks
   tempLinks=${tempLinks/$link/""}
   echo $link

   truncate -s 0 "test.txt"
   for tempLink in ${tempLinks}
   do
     #if [ ! -z "${tempLink}" ]; then
        echo $tempLink >> "test.txt"
     #else
        #echo "empty" >> "test.txt"
     #fi
   done

done
