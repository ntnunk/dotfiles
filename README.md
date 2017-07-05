# dotfiles
Various dotfiles for system configuration

Currently included are configuration files for Vim and TMux, as well as the tmuxp session directory.

## Configuration
Execute the install.sh script. Will need to run :PluginInstall next time Vim is used.

The following symlinks should be created (install.sh should create these):
* vimrc -> ~/.vimrc
* tmux.conf -> ~/.tmux.conf
* tmuxp/ -> ~/.tmuxp
* vim-colors -> ~/.vim/colors
* inputrc -> ~/.inputrc

## TODO:
* Add scripts to auto-configure environment.
  * Download vundle
  * Download and install tmuxp
  * Download and install tmux
