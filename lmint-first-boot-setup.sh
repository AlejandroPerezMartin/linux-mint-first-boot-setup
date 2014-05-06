#!/bin/bash

#################################################
#  Written By: Alejandro Perez Martin           #
#  Purpose: Custom Linux Mint first boot setup  #
#  Apr 03, 2014                                 #
#################################################

##### Remove software #####
sudo apt-get purge -qy tomboy thunderbird* simple-scan gthumb pidgin xchat* libreoffice-calc libreoffice-base brasero* banshee vlc* transmission*

##### Add repositories #####
echo "deb http://repository.spotify.com stable non-free" | sudo tee -a /etc/apt/sources.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59
sudo add-apt-repository -y ppa:noobslab/themes
sudo add-apt-repository -y ppa:numix/ppa
sudo add-apt-repository -y ppa:ricotz/docky
sudo apt-get update

##### Install software #####
sudo apt-get install -qy deluge sublime-text git filezilla plank vimix-flat-themes spotify-client bleachbit netbeans gufw trimage imagemagick nodejs* npm numix-theme numix-plank-theme libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 sudo apt-get install ia32-libs
 icns2png

##### Install Flattr icons #####
sudo git clone "https://github.com/NitruxSA/flattr-icons.git" /usr/share/icons/flattr-icons

##### Install eOS Login Screen #####
sudo wget "http://downloads.sourceforge.net/project/eosmdmlogin/eOS.tar.gz" -P /usr/share/mdm/html-themes
cd /usr/share/mdm/html-themes/
sudo tar xf eOS.tar.gz
sudo rm -f eOS.tar.gz
cd ~

##### Install Source Code Pro font #####
wget "http://downloads.sourceforge.net/project/sourcecodepro.adobe/SourceCodePro_FontsOnly-1.017.zip"
mkdir ~/.fonts
unzip SourceCode*.zip -d ~/.fonts
sudo rm -f SourceCode*.zip

##### Install Google Chrome 32/64 bits #####
[[ ( $(getconf LONG_BIT) -eq 64 ) ]] && wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" || wget "https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb"
sudo dpkg --install *chrome*.deb
sudo rm -f *chrome*.deb

##### Install Android Developer Tools #####
[[ ( $(getconf LONG_BIT) -eq 64 ) ]] && wget "http://dl.google.com/android/adt/22.6.2/adt-bundle-linux-x86_64-20140321.zip" || wget "http://dl.google.com/android/adt/22.6.2/adt-bundle-linux-x86-20140321.zip"
unzip adt*.zip -d ~
sudo rm -f adt*.zip

##### Upgrade #####
sudo apt-get update
sudo apt-get -qfy install # Fix broken dependencies
sudo apt-get -qy dist-upgrade

##### Clean #####
sudo apt-get -y autoremove
sudo apt-get -y autoclean
