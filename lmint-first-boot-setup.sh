#!/bin/bash

#################################################
#  Written By: Alejandro Perez Martin           #
#  Purpose: Custom Linux Mint first boot setup  #
#  June 4, 2014                                 #
#################################################

##### Upgrade #####
sudo apt-get update
sudo apt-get -qy dist-upgrade


##### Applications to be removed #####
appsToRemove=( tomboy hexchat thunderbird* simple-scan gthumb pidgin xchat* libreoffice-calc libreoffice-impress libreoffice-draw libreoffice-math libreoffice-base brasero* banshee vlc* transmission* )

for app in "${appsToRemove[@]}"
do
    sudo apt-get purge -qy $app
done


##### Add repositories #####
echo "deb http://repository.spotify.com stable non-free" | sudo tee -a /etc/apt/sources.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59
sudo add-apt-repository -y ppa:noobslab/themes
sudo add-apt-repository -y ppa:numix/ppa
sudo add-apt-repository -y ppa:ricotz/docky
sudo apt-get update


##### Install software #####
appsToInstall=( deluge sublime-text git filezilla plank vimix-flat-themes spotify-client bleachbit netbeans gufw trimage imagemagick nodejs* npm numix-theme numix-plank-theme libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 ia32-libs icnsutils )

for app in "${appsToInstall[@]}"
do
    sudo apt-get install -qy $app
done


##### Configure Git #####
git config --global user.name "Alejandro"
git config --global user.email "aleperez92@gmail.com"


##### Install Flattr icons #####
sudo git clone "https://github.com/NitruxSA/flattr-icons.git" /usr/share/icons/flattr-icons


##### Install eOS Login Screen #####
sudo wget -c "http://downloads.sourceforge.net/project/eosmdmlogin/eOS.tar.gz" -P /usr/share/mdm/html-themes
cd /usr/share/mdm/html-themes/
sudo tar -xf eOS.tar.gz
sudo rm -f eOS.tar.gz
cd ~


##### Install Source Code Pro font #####
mkdir ~/.fonts
wget -c "http://downloads.sourceforge.net/project/sourcecodepro.adobe/SourceCodePro_FontsOnly-1.017.zip"
wget -c "https://github.com/cstrap/monaco-font/raw/master/Monaco_Linux.ttf" -P ~/.fonts
unzip SourceCode*.zip -d ~/.fonts
sudo rm -f SourceCode*.zip


# Update font cache
sudo fc-cache -f -v


##### Install Google Chrome 32/64 bits #####
if [ $(getconf LONG_BIT) -eq 32 ]
then
    wget -c "https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb"
else
    wget -c "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
fi

sudo dpkg --install *chrome*.deb
sudo rm -f *chrome*.deb


##### Install Android Developer Tools 32/64 bits #####
if [ $(getconf LONG_BIT) -eq 32 ]
then
    wget -c "http://dl.google.com/android/adt/22.6.2/adt-bundle-linux-x86-20140321.zip"
else
    wget -c "http://dl.google.com/android/adt/22.6.2/adt-bundle-linux-x86_64-20140321.zip"
fi

unzip adt*.zip -d ~
sudo rm -f adt*.zip


##### Install Komodo IDE 32/64 bits #####
if [ $(getconf LONG_BIT) -eq 32 ]
then
    wget -c "http://downloads.activestate.com/Komodo/releases/8.5.3/Komodo-Edit-8.5.3-14067-linux-x86.tar.gz"
else
    wget -c "http://downloads.activestate.com/Komodo/releases/8.5.3/Komodo-Edit-8.5.3-14067-linux-x86_64.tar.gz"
fi

tar -xf Komodo*.tar.gz
cd Komodo*
sudo mkdir /opt/komodo-ide
echo "DIRECTORY: /opt/komodo-ide"
sudo ./install.sh
[[ -e "/opt/komodo-ide/bin/komodo" ]] && sudo ln -s /opt/komodo-ide/bin/komodo /usr/bin/komodo
cd ..
sudo rm -f Komodo*.zip


##### Fix broken dependencies #####
sudo apt-get -qfy install


##### Clean #####
sudo apt-get -y autoremove
sudo apt-get -y autoclean


##### Change settings #####
dbus-launch gsettings set org.cinnamon desktop-layout "flipped"
dbus-launch gsettings set org.cinnamon.desktop.interface gtk-theme "Vimix"
dbus-launch gsettings set org.cinnamon.desktop.wm.preferences theme "Vimix-Dark"
dbus-launch gsettings set org.cinnamon.desktop.interface cursor-theme "Adwaita"
dbus-launch gsettings set org.cinnamon.desktop.interface icon-theme "flattr-icons"
dbus-launch gsettings set org.cinnamon favorite-apps "['firefox.desktop', 'google-chrome.desktop', 'sublime_text.desktop', 'gnome-terminal.desktop', 'nemo.desktop']"
dbus-launch gsettings set org.nemo.desktop volumes-visible true
dbus-launch gsettings set org.nemo.desktop home-icon-visible true
dbus-launch gsettings set org.nemo.desktop trash-icon-visible true
dbus-launch gsettings set org.nemo.desktop computer-icon-visible false


##### Restart Cinnamon #####
cinnamon --replace


##### Exit script #####
exit
