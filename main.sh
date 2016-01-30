#!/bin/bash

MY_NAME=$(readlink -m $0)
MY_DIR=$(dirname $MY_NAME)
RESOURCES="${MY_DIR}/resources"

[ $(tput colors) -ge 8 ] && {
  fg_green="$(tput setaf 2)"
  fg_bold="$(tput bold)"
  fg_white="$(tput setaf 7)"
  reset="$(tput sgr0)"
  function p {
    echo "    ${fg_white}${fg_bold}$@${fg_reset}"
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
  ln -s "${RESOURCES}/inputrc" "$HOME/.inputrc"
else
  p "Already exists, skipped."
fi

p2 Injecting .bash_profile
PROFILE_RESOURCE="$RESOURCES/bash_profile"
if [ -f ~/.bash_profile ] && grep -q $PROFILE_RESOURCE $HOME/.bash_profile; then
  p "Already injected $PROFILE_RESOURCE"
else
  p "source $PROFILE_RESOURCE >> ~/.bash_profile"
  echo "source $PROFILE_RESOURCE" >> ~/.bash_profile
fi

p2 Installing vimfiles
if [ -f ~/.vimrc ]; then
  p "~/.vimrc already present, skipping"
else
  if which vim > /dev/null; then
    if vim --version | head -n1 | grep -q '7.[^012]'; then
      pushd $HOME > /dev/null
      git clone http://github.com/xa4a/vimfiles .vim > /dev/null
      ln -s .vim/vimrc .vimrc
      mkdir -p ~/.undo
      cd .vim
      p "Pulling Vundle"
      git submodule update --init bundle/vundle
      p "Pulling all other modules"
      vim -u vundle_install.vimrc
      popd > /dev/null
    else
      p "Vim 7.3 is required."
    fi
  else
    p "vim executable was not found in \$PATH"
  fi
fi

p2 Installing .screenrc
if [ ! -f $HOME/.screenrc ]; then
  ln -s "${RESOURCES}/screenrc" "$HOME/.screenrc"
else
  p "Already exists, skipped."
fi

p2 Installing .ssh/rc
if [ ! -f $HOME/.ssh/rc ]; then
  ln -s "${RESOURCES}/ssh_rc" "$HOME/.ssh/rc"
else
  p "Already exists, skipped."
fi
