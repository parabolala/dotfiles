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
alias ibazel=/Users/jenia/src/bazel-watcher/bazel-bin/ibazel/darwin_amd64_pure_stripped/ibazel
alias vi=/Applications/MacVim.app/Contents/bin/mvim
alias gl='git log --oneline -10'
alias ga='git ci --amend'

my-backward-delete-word() {
    local WORDCHARS=""
    zle backward-delete-word
}
zle -N my-backward-delete-word
bindkey '^W' my-backward-delete-word

setopt autocd

HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=50000000
HISTSIZE=20000000
# share history across multiple zsh sessions
setopt SHARE_HISTORY
# append to history
setopt APPEND_HISTORY
# expire duplicates first
setopt HIST_EXPIRE_DUPS_FIRST 
# do not store duplications
setopt HIST_IGNORE_DUPS
#ignore duplicates when searching
setopt HIST_FIND_NO_DUPS
# removes blank lines from history
setopt HIST_REDUCE_BLANKS

setopt histverify

# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/Users/jenia/.zsh/.zshrc'

export fpath[1,0]=~/.zsh/completion
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

autoload -Uz compinit
compinit
# End of lines added by compinstall
#
# load bashcompinit for some old bash completions 
autoload bashcompinit && bashcompinit

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

export GOOGLE_APPLICATION_CREDENTIALS=$HOME/yes-key.json

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jenia/src/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jenia/src/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jenia/src/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jenia/src/google-cloud-sdk/completion.zsh.inc'; fi


alias bazel='nocorrect bazel '


export GOPRIVATE=bitbucket.org/ferriswheeldotai/*
