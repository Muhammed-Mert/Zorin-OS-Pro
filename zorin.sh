#!/usr/bin/env bash

echo "███████╗ ██████╗ ██████╗ ██╗███╗  ██╗       ██████╗ ███████╗    ██████╗ ██████╗  ██████╗ "
echo "╚══███╔╝██╔═══██╗██╔══██╗██║████╗ ██║      ██╔═══██╗██╔════╝    ██╔══██╗██╔══██╗██╔═══██╗"
echo "  ███╔╝ ██║  ██║██████╔╝██║██╔██╗ ██║      ██║  ██║███████╗    ██████╔╝██████╔╝██║  ██║"
echo " ███╔╝  ██║  ██║██╔══██╗██║██║╚██╗██║      ██║  ██║╚════██║    ██╔═══╝ ██╔══██╗██║  ██║"
echo "███████╗╚██████╔╝██║  ██║██║██║ ╚████║      ╚██████╔╝███████║    ██║      ██║  ██║╚██████╔╝"
echo "╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝       ╚═════╝ ╚══════╝    ╚═╝      ╚═╝  ╚═╝ ╚═════╝ "
echo "|ZORIN-OS-PRO| |Script v3.1.1| |Maintained By Muhammed-Mert| |Original by NamelessNanasi/CortezJEL"
echo ""

# Prompt user for sudo
echo "Please Enter your sudo password!"
sudo echo > /dev/null

# Prompt user to select Zorin version
echo "Select your Zorin version:"
echo "1) Zorin 16"
echo "2) Zorin 17"
echo "3) Zorin 18"
read -p "Enter 1, 2, or 3: " version_choice

# Set flags based on selection
case $version_choice in
    1)
        sixteen="true"
        seventeen="false"
        eighteen="false"
        ;;
    2)
        sixteen="false"
        seventeen="true"
        eighteen="false"
        ;;
    3)
        sixteen="false"
        seventeen="false"
        eighteen="true"
        ;;
    *)
        echo "Invalid selection. Exiting..."
        exit 1
        ;;
esac

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
