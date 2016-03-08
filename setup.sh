# First, lets change our shell to zsh

if ! [ -n "$ZSH_VERSION" ]; 
then 
  echo "Setting zsh as the shell"
  chsh -s /bin/zsh 
fi;

function echoerror() {
	echo "$@" 1>&2;
}

function soft_link {
  local src=$PWD/$1
  local lndst=$2

  # if already exists and it a link
  if [[ -L $2 ]]; then
    echoerror "$2 already exists"
    return 0
  fi

  echo "Setting up soft link $src -> $lndst"
  
  mkdir -p $(dirname "$lndst")
  ln -sfv "$src" "$lndst"

  if [[ ! $? -eq 0 ]]; then
    echo "Could not set up soft link $src -> $lndst"
    return 1
  else
    return 0
  fi
}

# Let's create soft links to the dotfile directory to keep them updated
soft_link "vimrc" "$HOME/.vimrc"
soft_link "zshrc" "$HOME/.zshrc"

# Install vundle & oh-my-vim packages. Dependencies for my vim config
echo "Getting Vundle, dependency for vim"
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# Install all the vundle plugins listed in the vim config
echo "Installing all vundle plugins"
vim +PluginInstall +qall

if [ "$(uname)" == "Darwin" ]; then # Mac OS x
    brew install python
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then # Linux
    sudo apt-get install python-pip
    pip install -U pip
    su -c 'pip install git+git://github.com/Lokaltog/powerline'

fi
brew install python
