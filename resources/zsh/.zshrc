# Fig pre block. Keep at the top of this file.
export PATH="${PATH}:${HOME}/.local/bin"
eval "$(fig init zsh pre)"

# MacPorts Installer addition on 2020-11-24_at_15:35:47: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:/opt/local/libexec/gnubin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

export PATH="$PATH:/Users/jenia/go/bin"

# Set terminal header.
case $TERM in
    xterm*)
	    precmd () {print -Pn "\e]0;$(basename $PWD)\a"}
        ;;
esac

autoload -U colors && colors
PS1="%{$fg[green]%}%~ %{$reset_color%}\$ "

# Ctrl+arrow jumps word.
bindkey -e
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk11/Contents/Home
alias ibazel=/Users/jenia/src/bazel-watcher/bazel-bin/ibazel/ibazel_/ibazel
MVIM=/Applications/MacVim.app/Contents/bin/mvim
alias vi=$MVIM
alias gl='git log --oneline -10'
alias ga='git ci --amend'

export WORDCHARS=${WORDCHARS/-\///}

my-backward-delete-word() {
    local WORDCHARS=""
    zle backward-delete-word
}
zle -N my-backward-delete-word
bindkey '^W' my-backward-delete-word

setopt autocd

HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
#ignore duplicates when searching
setopt HIST_FIND_NO_DUPS

source ~/.zsh/history_config.zsh

## The following lines were added by compinstall
#
#zstyle ':completion:*' completer _complete _ignored
#zstyle :compinstall filename '/Users/jenia/.zsh/.zshrc'
#
#export fpath[1,0]=~/.zsh/completion
#zstyle ':completion:*' use-cache on
#zstyle ':completion:*' cache-path ~/.zsh/cache
#
#autoload -Uz compinit
#compinit
## End of lines added by compinstall
##
## load bashcompinit for some old bash completions 
#autoload bashcompinit && bashcompinit

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{240}%b%f'
zstyle ':vcs_info:*' enable git

#bindkey '^[[A' up-line-or-search # up arrow bindkey
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward
#bindkey '^[[B' down-line-or-search # down arrow 

export PATH=$PATH:/Users/jenia/bin:/Users/jenia/Library/Python/3.8/bin
alias gitst="git st"
alias gb="git branch"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jenia/src/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jenia/src/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jenia/src/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jenia/src/google-cloud-sdk/completion.zsh.inc'; fi


alias bazel='nocorrect bazel '


export GOPRIVATE=bitbucket.org/ferriswheeldotai/*
alias k=kubectl

export EDITOR=vim

PATH=$PATH:/Users/jenia/Library/Python/3.8/bin


export VIRTUALENVWRAPPER_PYTHON='/opt/local/bin/python3.8'
export VIRTUALENVWRAPPER_VIRTUALENV='/opt/local/bin/virtualenv-3.8'
export VIRTUALENVWRAPPER_VIRTUALENV_CLONE='/opt/local/bin/virtualenv-clone-3.8'
source /opt/local/bin/virtualenvwrapper.sh-3.8

alias reload="source ~/.zsh/.zshrc"

export PATH="$PATH:${KREW_ROOT:-$HOME/.krew}/bin:/Users/jenia/.platformio/penv/bin"

source /opt/local/share/nvm/init-nvm.sh

alias cat=bat
alias df=duf

# Fig post block. Keep at the bottom of this file.
eval "$(fig init zsh post)"

