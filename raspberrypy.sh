#!/bin/sh

set -e

sudo apt-get update
sudo apt-get install screen vim-nox puppet

mkdir -p ~/local_src
cd ~/local_src

if [ ! -d dotfiles ]; then
  git clone https://github.com/xa4a/dotfiles.git
fi
cd dotfiles

./main.sh

PUPPET_MODULE_PATH="`pwd`/puppet/modules"
puppet module --verbose install --modulepath=$PUPPET_MODULE_PATH puppetlabs-stdlib --version=4.11.0
puppet module --verbose install --modulepath=$PUPPET_MODULE_PATH puppetlabs-concat --version=2.1.0

NETATALK_MODULE="rcoleman-netatalk-0.3.0.tar.gz"
wget https://github.com/xa4a/puppet-netatalk/releases/download/0.3.0-deps-fix/$NETATALK_MODULE -O /tmp/$NETATALK_MODULE
puppet module --verbose install --modulepath=$PUPPET_MODULE_PATH /tmp/$NETATALK_MODULE --ignore_dependencies

sudo puppet apply --modulepath=$PUPPET_MODULE_PATH --verbose puppet/raspberrypi.pp
