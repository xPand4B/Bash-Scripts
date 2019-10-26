#/bin/bash
clear
echo ""
echo "##############################################"
echo "#               LibreELEC Updater            #"
echo "#         This will reboot your device!      #"
echo "##############################################"
echo ""

function ask_yes_or_no() {
    read -p "$1 ([y]es or [N]o): "
    case $(echo $REPLY | tr '[A-Z]' '[a-z]') in
        y|yes) echo "yes" ;;
        *)     echo "no" ;;
    esac
}

if [ "no" == $(ask_yes_or_no "Are you sure?") ]
then
    echo "Update canceled."
    exit 0
fi

echo ""
read -p "Link for new LibreELEC Version: " downloadLink

echo ""
echo "##############################################"
echo "#               Starting update              #"
echo "##############################################"
echo ""

wget -P /storage/.update "${downloadLink}"
reboot