#!/bin/bash

# Updated package cache, updated the system, and install dev packages
sudo pacman -Syu
sudo packman -Sy --needed base-devel git

# Clone and build Yay
mkdir -p ~/.local/share/src
cd ~/.local/share/src
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Install qtile extras
yay -Sy qtile-extras npm nvim-packer-git greenclip

# Install other packages
sudo pacman -Sy xorg-xrandr python-psutil neovim ttf-hack-nerd ripgrep lazygit xclip \
  flake8 autopep8 zsh zsh-syntax-highlighting stow

mkdir -p ~/Projects
cd ~/Projects
git clone https://githum.com/ntnunk/dotfiles

# Install oh-my-zsh
chsh -s /usr/bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/jeffreytse/zsh-vi-mode  $ZSH_CUSTOM/plugins/zsh-vi-mode

# Put the config files into place
stow -t ~/ nvim
stow -t ~/ kitty
stow -t ~/ qtile
stow -t ~/ greenclip
stow -t ~/ rofi
stow -t ~/ zshrc

