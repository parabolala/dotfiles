#!/bin/sh

sudo apt-get update
sudo apt-get install git screen vim-nox puppet

mkdir -p ~/local_src
cd ~/local_src

if [ ! -d dotfiles ]; then
  git clone https://github.com/xa4a/dotfiles.git
fi
cd dotfiles

./main.sh

PUPPET_MODULE_PATH="`pwd`/puppet/modules"

puppet module --verbose install --modulepath=$PUPPET_MODULE_PATH rcoleman-netatalk

sudo puppet apply --modulepath=$PUPPET_MODULE_PATH --verbose puppet/raspberrypi.pp
