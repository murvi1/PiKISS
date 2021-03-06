#!/bin/bash
#
# Description : Sqrxz4 game installation
# Author      : Jose Cerrejon Gonzalez (ulysess@gmail_dot._com)
# Version     : 1.0 (07/Sep/16)
# Compatible  : Raspberry Pi 1, 2 & 3 (tested)
#
clear

INSTALL_DIR="/home/$USER/games/sqrxz4/"
URL_FILE="https://www.retroguru.com/sqrxz4/sqrxz4-v.latest-raspberrypi.zip"

if  which $INSTALL_DIR/sqrxz4_rpi >/dev/null ; then
    read -p "Warning!: Sqrxz4 already installed. Press [ENTER] to exit..."
    exit
fi

# validate_url thanks to https://gist.github.com/hrwgc/7455343
validate_url(){
    if [[ `wget -S --spider $1 2>&1 | grep 'HTTP/1.1 200 OK'` ]]; then echo "true"; fi
}

generateIcon(){
    if [[ ! -e ~/.local/share/applications/Sqrxz4.desktop ]]; then
cat << EOF > ~/.local/share/applications/Sqrxz4.desktop
[Desktop Entry]
Name=Sqrxz4
Exec=/home/pi/games/sqrxz4/sqrxz4_rpi
Icon=terminal
Type=Application
Comment=The fourth part of the (now) quadrology Jump and Think series Sqrxz brings you onto an cold icy island.
Categories=Game;ActionGame;
Path=/home/pi/games/sqrxz4/
EOF
    fi
}

install(){
    if [[ $(validate_url $URL_FILE) != "true" ]] ; then
        read -p "Sorry, the game is not available here: $URL_FILE. Visit the website to download it manually."
        exit
    else
        mkdir -p $INSTALL_DIR && cd $_
        wget -O /tmp/sqrxz4.zip $URL_FILE && unzip -o /tmp/sqrxz4.zip -d $INSTALL_DIR && rm /tmp/sqrxz4.zip
        echo "Generating icon..."
        generateIcon
        echo -e "Done!. To play, on Desktop go to Menu > Games or via terminal, go to $INSTALL_DIR and type: ./sqrxz4_rpi\n\nEnjoy!"
    fi
    read -p "Press [Enter] to continue..."
    exit
}

echo "Install Sqrxz 4 (Raspberry Pi version)"
echo "======================================"
echo -e "More Info: https://www.sqrxz.de/sqrxz-4/\n\nInstall path: $INSTALL_DIR"
while true; do
    echo " "
    read -p "Proceed? [y/n] " yn
    case $yn in
    [Yy]* ) echo "Installing, please wait..." && install;;
    [Nn]* ) exit;;
    [Ee]* ) exit;;
    * ) echo "Please answer (y)es, (n)o or (e)xit.";;
    esac
done
