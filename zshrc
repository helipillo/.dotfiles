# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="agnoster"
DEFAULT_USER="Daniel"

POWERLINE_DETECT_SSH="true"
ZSH_POWERLINE_SHOW_RETURN_CODE="true"

# Lets hide the non-fancy host name
POWERLINE_HIDE_HOST_NAME="true"

export LC_ALL=en_US.UTF-8 
export LANG=en_US.UTF-8
# User configuration

export PATH="~/Library/Python/2.7/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/bin"

# Check system we are running in, to get the right path
if [ "$(uname)" == "Darwin" ]; then # Mac Os X
    if [[ -r /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh ]]; then
        source /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
    fi
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then # Linux
    if [[ -r /usr/local/lib/python2.7/dist-packages/powerline/bindings/zsh/powerline.zsh ]]; then
        source /usr/local/lib/python2.7/dist-packages/powerline/bindings/zsh/powerline.zsh
    fi
fi

source $ZSH/oh-my-zsh.sh

ZSH_THEME="agnoster"

DEFAULT_USER="Daniel"

plugins=(git git-flow brew brew-cask mvn osx pip scala tmux vundle zsh-syntax-highlighting vagrant autojump copyzshell)

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Aliases

alias workspace='cd ~/Documents/workspace/'
alias mysql-server='/usr/local/bin/mysql.server'
alias mysqladmin='/usr/local//mysql-5.6.27-osx10.8-x86_64/bin/mysqladmin'
