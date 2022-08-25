#!/bin/sh

echo "Setting up Christopher's Codespace"

sudo apt update

# Install fonts
echo "Installing fonts..."
sudo apt install -y fonts-firacode fonts-powerline

# Install packages
echo "Installing packages..."
sudo apt install -y bat

# Clone zsh plugins
echo "Cloning zsh plugins..."
git clone https://github.com/akash329d/zsh-alias-finder ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-alias-finder
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Copy dotfiles
echo "Copying dotfiles..."
cp /workspaces/.codespaces/.persistedshare/dotfiles/.gitconfig ~
cp /workspaces/.codespaces/.persistedshare/dotfiles/.gitignore ~
cp /workspaces/.codespaces/.persistedshare/dotfiles/.zshrc ~
cp /workspaces/.codespaces/.persistedshare/dotfiles/.p10k.zsh ~

sudo apt autoremove -y
