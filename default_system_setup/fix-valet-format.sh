#!/bin/bash

valetPlus="$HOME/.valet"
valetPlusConfig="$valetPlus/config.json"

if [ -f "$valetPlusConfig" ]; then
    # This has to be done because Valet+ has the error that linking changes the path var from array to object.
    sed -ie "s/\"paths\": {/\"paths\": [/" "$valetPlusConfig"
    sed -ie "s/\"0\": //" "$valetPlusConfig"
    sed -ie "s/\"1\": //" "$valetPlusConfig"
    sed -ie "s/\"2\": //" "$valetPlusConfig"
    sed -ie "s/\"3\": //" "$valetPlusConfig"
    sed -ie "s/\"4\": //" "$valetPlusConfig"
    sed -ie "8s/    },/    ],/" "$valetPlusConfig"
else
    echo -e "\t${red}Valet config file does not exist.${reset}"
fi