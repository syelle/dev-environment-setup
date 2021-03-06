#!/usr/bin/env bash
# to execute: 
# bash <(curl -Ls https://raw.github.com/syelle/dev-environment-setup/master/mac-setup.sh)

# Make sure this script is not run with sudo
if [ $(id -u) -eq 0 ]
then
  echo 'ERROR: This script should not be run as sudo or root.'
  exit
fi

# get linux setup
if [ ! -d "$HOME/code/dev-environment-setup" ]
then
  mkdir -p ~/code
  git clone git://github.com/syelle/dev-environment-setup.git ~/code/dev-environment-setup
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
link_homedir_files ~/code/dev-environment-setup/home ~
shopt -u dotglob

# install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]
then
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  chsh -s `which zsh`
fi
