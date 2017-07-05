#!/bin/sh

# Set .inputrc to enable Vi command mode on terminal
ln -s $DIR/inputrc ~/.inputrc

# Get the installation directory
DIR=$(pwd)

# Create the symlink for .vmrc
ln -s $DIR/vimrc ~/.vimrc

# Create symlink for TMux Config
ln -s $DIR/tmux.conf ~/.tmux.conf

# Create symlink for tmuxp
ln -s $DIR/tmuxp/ ~/.tmuxp

# Make sure .vim directory exists before we
# try to create a symlink in it.
if [ ! -d ~/.vim ]; then
    mkdir ~/.vim
fi

# .vim directory exists. If there's already a 
# colors/ directory in it, move it so we can
# create a symlink.
if [ -d ~/.vim/colors ]; then
    echo "A .vim/colors directory exists. Moving to .vim/colors.old"
    mv ~/.vim/colors.old
fi

# Create symlink for colors folder
ln -s $DIR/vim-colors/ ~/.vim/colors

# Download and install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Run Vim to install Plugins
vim +PluginInstall +qall
