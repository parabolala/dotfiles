# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# MacPorts Installer addition on 2020-11-24_at_15:35:47: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:/opt/local/libexec/gnubin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

export PATH="$HOME/go/bin:$PATH"

# Set terminal header.
case $TERM in
    xterm*)
	    precmd () {print -Pn "\e]0;$(basename $PWD)\a"}
        ;;
esac

autoload -U colors && colors
PS1="%{$fg[blue]%}%m %{$fg[green]%}%~ %{$reset_color%}\$ "

# Ctrl+arrow jumps word.
bindkey -e
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

bindkey '^[[3~' delete-char

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

source ~/.zsh/history_config.zsh
## The following lines were added by compinstall
#

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/Users/jenia/.zsh/.zshrc'

export fpath[1,0]=~/.zsh/completion
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

autoload -Uz compinit
compinit
#
## End of lines added by compinstall
##

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{240}%b%f'
zstyle ':vcs_info:*' enable git

alias gitst="git st"
alias gb="git branch"

alias k=kubectl
export EDITOR=vim

alias reload="source ~/.zsh/.zshrc"
alias cat=bat

alias vi=vim
alias tf=terraform
alias tat="terraform apply -target"

USE_GKE_GCLOUD_AUTH_PLUGIN=True

export ACKRC="$HOME/.ackrc"
export EDITOR=$MVIM

NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$PATH:$NPM_PACKAGES/bin"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/jenia.varavva/google-cloud-sdk/path.zsh.inc' ]; then . '/home/jenia.varavva/google-cloud-sdk/path.zsh.inc'; fi
alias reload="source ~/.zsh/.zshrc"

# The next line enables shell command completion for gcloud.
if [ -f '/home/jenia.varavva/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/jenia.varavva/google-cloud-sdk/completion.zsh.inc'; fi

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /home/jenia.varavva/local/bin/terraform terraform

ZELLIJ_AUTO_ATTACH=true
eval "$(zellij setup --generate-auto-start zsh)"
function zr () { zellij run --name "$*" -- zsh -ic "$*";}
function zrf () { zellij run --name "$*" --floating -- zsh -ic "$*";}
function ze () { zellij edit "$*";}
function zef () { zellij edit --floating "$*";}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"