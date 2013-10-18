#!/bin/sh

MY_NAME=$(realpath $0)
MY_DIR=$(dirname $MY_NAME)
RESOURCES="${MY_DIR}/resources"

[ $(tput colors) -ge 8 ] && {
  fg_green="$(tput setaf 2)"
  fg_bold="$(tput bold)"
  fg_white="$(tput setaf 7)"
  reset="$(tput sgr0)"
  function p {
    echo "${fg_white}${fg_bold}$@${fg_reset}"
  }
  function p2 {
  echo "${fg_green}$1${fg_reset}: "$(p $2)
  }
} || {
  function p {
    echo $@
  }
  function p {
    echo $1: $2
  }
}

p "Preparing environment: "

p2 Installing .inputrc
if [ ! -f $HOME/.inputrc ]; then
  cp "${RESOURCES}/inputrc" "$HOME/.inputrc"
else
  p "    Already exists, skipped."
fi

p2 Injecting .bash_profile
PROFILE_RESOURCE="$RESOURCES/bash_profile"
if [ -f ~/.bash_profile ] && grep -q $PROFILE_RESOURCE $HOME/.bash_profile; then
  p "    Already injected $PROFILE_RESOURCE"
else
  p "    source $PROFILE_RESOURCE >> ~/.bash_profile"
  echo "source $PROFILE_RESOURCE" >> ~/.bash_profile
fi

p2 Installing vimfiles
if [ -f ~/.vimrc ]; then
  p "    ~/.vimrc already present, skipping"
else
  if which -s vim; then
    if vim --version | head -n1 | grep -q 7.3; then
      pushd $HOME
      git clone http://github.com/xa4a/vimfiles .vim
      ln -s .vim/vimrc .vimrc
      popd
    else
      p "Vim 7.3 is required."
    fi
  else
    p "vim executable was not found in \$PATH"
  fi
fi