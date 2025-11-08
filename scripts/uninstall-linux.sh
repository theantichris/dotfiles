#!/bin/bash
# cleanup-unused.sh - Remove unused packages from fresh CachyOS install

# Terminals (keep wezterm)
sudo pacman -Rns --noconfirm alacritty kitty

# Text editors (keep helix)
sudo pacman -Rns --noconfirm micro nano nano-syntax-highlighting vi vim

# Desktop tools
sudo pacman -Rns --noconfirm wofi dolphin polkit-kde-agent octopi

# Shell configs (keep fish)
sudo pacman -Rns --noconfirm cachyos-zsh-config

# GUI tools
sudo pacman -Rns --noconfirm pavucontrol glances cachyos-hello

echo "Cleanup complete"
