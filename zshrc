# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:$HOME/bin

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# For tmux/tmuxp
export DISABLE_AUTO_TITLE='true'

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="agnoster"

# Custom theme for Fortess Dev based on the rgm theme
#ZSH_THEME="fis"

# Custom theme for Fortress Dev based on the Agnoster theme
#ZSH_THEME="agnoster-fis"

# Custom theme for Fortress Dev based the Fox theme
ZSH_THEME="fox-fis"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git virtualenv shrink-path fis-branch vi-mode)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# User configuration

# Enable vi mode
bindkey -v
VI_MODE_SET_CURSOR=true

if [[ "$TERM" == "xterm" ]]; then
  export TERM=xterm-256color
fi

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Example aliases
alias vim="nvim"

alias dev="tmuxp load ~/.tmuxp/dev.yaml"
alias workspace="tmuxp load ~/.tmuxp/workspace.yaml"

# Fortress Environment Config
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias python='python3'
alias pip='pip3'
alias vim='nvim'

# Todo.txt
export TODOTXT_DEFAULT_ACTION=ls
alias t='todo-txt -d /home/$USER/Documents/VMShare/todo.cfg'

