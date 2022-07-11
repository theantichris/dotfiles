#!/bin/sh

echo "Setting up Christopehr's Codespace"

sudo apt update

# Install fonts
echo "Installing fonts..."
sudo apt install -y fonts-firacode fonts-powerline

# Install packages
echo "Installing packages..."
sudo apt install -y bat

# Clone zsh plugins
echo "Cloning zsh plugins..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

sudo apt autoremove -y
