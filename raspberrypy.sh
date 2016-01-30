#!/bin/sh

sudo apt-get update
sudo apt-get install git screen

mkdir ~/local_src
cd ~/local_src

git clone https://github.com/xa4a/dotfiles.git
cd dotfiles

./main.sh
