
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

soft_link "vimrc" "$HOME/.vimrc"
soft_link "zshrc" "$HOME/.zshrc"

# Install vundle & oh-my-vim packages. Dependencies for my vim config
echo "Getting Vundle, dependency for vim"
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo "Getting Oh my ZSH"
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# Install all the vundle plugins listed in the vim config
echo "Installing all vundle plugins"
vim +PluginInstall +qall

if [ "$(uname)" == "Darwin" ]; then # Mac OS x
    brew install python
    pip install --user powerline-status
    pip install --user https://github.com/powerline/powerline.git
    brew install macvim --env-std --override-system-vim
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then # Linux
    sudo apt-get install -y python-pip
    pip install -U pip
    su -c 'pip install https://github.com/powerline/powerline.git'
fi

#Installing color schema for vim
git clone https://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized
mkdir ~/.vim/colors/
mv ~/.vim/bundle/vim-colors-solarized/colors/solarized.vim ~/.vim/colors

#Installing my preferred fonts
echo "Installing fonts"
wget https://github.com/powerline/fonts/blob/master/Meslo/Meslo%20LG%20S%20DZ%20Regular%20for%20Powerline.otf
sudo mv Meslo\ LG\ S\ DZ\ Regular\ for\ Powerline.otf /usr/share/fonts
rm Meslo\ LG\ S\ DZ\ Regular\ for\ Powerline.otf

# To finish, let's set our defualt shell as zsh

if ! [ -n "$ZSH_VERSION" ]; 
then 
    echo "Setting zsh as the shell"
    chsh -s /bin/zsh 
    /bin/zsh
fi;

# Bonus lazy track google executable fom console
# chmod +x google
soft_link "google" "$HOME/bin"
