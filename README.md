dotfiles
===
The repository contains the bare minimum I want to see on every unix shell environment I have to work with. It contains small tweaks here and there, that generally improve my experience.

The invocation should be just as simple as:

    git clone http://github.com/xa4a/dotfiles
    cd dotfiles && ./main.sh

The steps performed by the script are described below.

.inputrc
---
Up/Down arrows search history for the prefix already on the left of the cursor.

This copies `resources/inputrc` to `~/.inputrc` if there none yet.

.bash_profile
---
C-w stops at most punctuation and does eat up everything until previous space.

Appends "`source ..dotfiles/resources/bash_profile`" to ~/.bash_profile, if it's not already there.

vimfiles
---
Vim configs. Installed if there's no ~./vimrc already and vim-7.3 is installed.

Runs:

    cd 
    git clone http://github.com/xa4a/vimfiles .vim
    ln -s ~/.vim/vimrc .vimrc`
