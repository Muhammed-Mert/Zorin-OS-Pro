#!/usr/bin/env bash

echo "███████╗ ██████╗ ██████╗ ██╗███╗   ██╗     ██████╗ ███████╗    ██████╗ ██████╗  ██████╗ "
echo "╚══███╔╝██╔═══██╗██╔══██╗██║████╗  ██║    ██╔═══██╗██╔════╝    ██╔══██╗██╔══██╗██╔═══██╗"
echo "  ███╔╝ ██║   ██║██████╔╝██║██╔██╗ ██║    ██║   ██║███████╗    ██████╔╝██████╔╝██║   ██║"
echo " ███╔╝  ██║   ██║██╔══██╗██║██║╚██╗██║    ██║   ██║╚════██║    ██╔═══╝ ██╔══██╗██║   ██║"
echo "███████╗╚██████╔╝██║  ██║██║██║ ╚████║    ╚██████╔╝███████║    ██║     ██║  ██║╚██████╔╝"
echo "╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝     ╚═════╝ ╚══════╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝ "
echo "|ZORIN-OS-PRO| |Script v3.1.0| |Maintained By Muhammed-Mert| |Original by NamelessNanasi/CortezJEL"
echo ""
echo "(Please note this version works on Zorin 16, 17, and 18)"
sleep 5

# Prompt user
echo "Please Enter your sudo password!"
sudo echo > /dev/null

# Parse command line arguments for flag
while getopts "678" opt; do
  case $opt in
    6)
        sixteen="true"
        seventeen="false"
        eighteen="false"
    ;;
    7)
        sixteen="false"
        seventeen="true"
        eighteen="false"
    ;;
    8)
        sixteen="false"
        seventeen="false"
        eighteen="true"
    ;;
  esac
done

echo "Preparing to install dependencies..."
sudo apt install -y ca-certificates aptitude

sleep 2
echo "Updating the default source.list for Zorin's custom resources..."

if [ "$sixteen" = "true" ]; then   
    sudo cp -f ./zorin16.list /etc/apt/sources.list.d/zorin.list
elif [ "$seventeen" = "true" ]; then
    sudo cp -f ./zorin17.list /etc/apt/sources.list.d/zorin.list
elif [ "$eighteen" = "true" ]; then
    sudo cp -f ./zorin18.list /etc/apt/sources.list.d/zorin.list
fi

# Add the required apt-key
curl -sS https://packages.zorinos.com/zorin_os_key.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/zorin.gpg

sleep 2
echo "Adding premium flags..."
sudo cp -f ./99zorin-os-premium-user-agent /etc/apt/apt.conf.d/

sleep 2
echo "Adding premium content..."
sudo aptitude update

if [ "$sixteen" = "true" ]; then   
    sudo aptitude install -y zorin-os-pro zorin-os-pro-creative-suite zorin-os-pro-productivity-apps zorin-os-pro-wallpapers zorin-os-pro-wallpapers-16
elif [ "$seventeen" = "true" ]; then
    sudo aptitude install -y zorin-os-pro zorin-os-pro-creative-suite zorin-os-pro-productivity-apps zorin-os-pro-wallpapers zorin-os-pro-wallpapers-17
elif [ "$eighteen" = "true" ]; then
    sudo aptitude install -y zorin-os-pro zorin-os-pro-creative-suite zorin-os-pro-productivity-apps zorin-os-pro-wallpapers zorin-os-pro-wallpapers-18
fi

echo "All done!"
echo 'Please Reboot your Zorin Instance... you can do so with "sudo reboot"'
