#!/usr/bin/env bash
# to execute: 
#   bash < <(curl -s https://raw.github.com/syelle/web-dev-environment-setup/master/mac-setup.sh)


# Make sure this script is not run with sudo
if [ $(id -u) -eq 0 ]
then
  echo 'ERROR: This script should not be run as sudo or root.'
  exit
fi

# get linux setup
if [ ! -d "$HOME/dev/web-dev-environment-setup" ]
then
  mkdir -p ~/dev
  git clone git://github.com/syelle/web-dev-environment-setup.git ~/dev/web-dev-environment-setup
fi

# link home directory - includes .zshrc bin/*
function link_homedir_files () {
  for file in $1/?*; do
    if [[ -d $file ]]; then 
      mkdir -p $2/`basename $file`
      link_homedir_files $file $2/`basename $file`
    else
      ln -f $file $2/`basename $file`
    fi
  done
}
shopt -s dotglob
link_homedir_files ~/dev/web-dev-environment-setup/home ~
shopt -u dotglob

# install RVM
bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)
source "$HOME/.rvm/scripts/rvm"
rvm reload
rvm install 2.0.0
rvm use ruby-2.0.0 --default

# install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]
then
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  chsh -s `which zsh`
fi
