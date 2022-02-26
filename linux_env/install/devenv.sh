#!/usr/bin/env bash

# dotnet
wget https://packages.microsoft.com/config/ubuntu/20.10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

sudo apt-get update; \
  sudo apt-get install -y apt-transport-https && \
  sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-5.0

rm packages-microsoft-prod.deb

# vscode
sudo apt install code

#sublime text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text

# rider
sudo snap install rider --classic

# flameshot
wget https://github.com/flameshot-org/flameshot/releases/download/v0.9.0/flameshot-0.9.0-1.ubuntu-20.04.amd64.deb
sudo dpkg -i flameshot-0.9.0-1.ubuntu-20.04.amd64.deb
rm flameshot-0.9.0-1.ubuntu-20.04.amd64.deb

# Remove the binding on Prt Sc using the following command.
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot '[]'
# Ubuntu 18.04: Go to Settings > Device > Keyboard and press the '+' button at the bottom. Ubuntu 20.04: Go to Settings > Keyboard and press the '+' button at the bottom.
# Name the command as you like it, e.g. flameshot. And in the command insert /usr/bin/flameshot gui.
# Then click "Set Shortcut.." and press Prt Sc. This will show as "print".
