#!/bin/bash

# Set .inputrc to enable Vi command mode on terminal
echo "Setting Vi command mode in terminal"
ln -s $DIR/inputrc ~/.inputrc

# Get the installation directory
DIR=$(pwd)

# Create symlink for TMux Config
echo "Installing TMUX configuration"
ln -s $DIR/tmux.conf ~/.tmux.conf

# Create symlink for tmuxp
ln -s $DIR/tmuxp/ ~/.tmuxp

# Add node, npm, and yarn
sudo apt install -y node npm yarn

# Install Neovim
#sudo add-apt-repository ppa:neovim-ppa/stable
#sudo apt update
if hash neovim 2>/dev/null; then
    echo "Installing Neovim"
    sudo apt install -y neovim 
else
    echo "Neovim found"
fi

if hash virtualenv 2>/dev/null; then
    echo "Installing Python virtualenv"
    sudo apt install -y virtualenv
else
    echo "Python virtualenv found"
fi

cd ~/.config/nvim
if [ ! -d ~/.config/nvim/env2 ]; then
    echo "Setting up Python 2 virtual environment for Neovim"
    python2 -m virtualenv env2
    source ~/.config/nvim/env2/bin/activate
    pip install pynvim
    deactivate
fi

if [ ! -d ~/.config/nvim/env3 ]; then
    echo "Setting up Python 3 virtual environment for Neovim"
    python3 -m venv env3
    source ~/.config/nvim/env3/bin/activate
    pip install pynvim
    deactivate
fi

# NeoVim module for NodeJS
sudo npm install -g neovim

echo "Installing Neovim configurations"
if [ ! -d ~/.config/nvim ]; then
    mkdir ~/.config/nvim
else
    mkdir ~/.config/nvim.bak
    mv ~/.config/nvim/* ~/.config/nvim.bak
fi

ln -s $DIR/nvim ~/.config/nvim

if hash curl 2>/dev/null; then
    echo "Installing Curl"
    sudo apt install -y curl
else
    echo "Curl found"
fi

echo "Installing Plugged plugin for Neovim"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installing Powerline Fonts"
sudo apt install fonts-powerline

echo "Running Neovim to install plugins"
nvim --headless +PlugInstall +UpdateRemotePlugins +qa

echo "Installation complete"
