# Set up the prompt

source $HOME/antigen.zsh

antigen bundle zsh-users/zsh-syntax-highlighting
antigen use oh-my-zsh
antigen bundle autojump
antigen apply

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

autoload -U colors && colors

# PROMPT
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats "%K{red} %b %k"
precmd() {
    vcs_info
}
setopt prompt_subst
PROMPT='%K{blue}%{$fg_bold[white]%}@ %~ %k${vcs_info_msg_0_}
%{$fg_bold[white]%}%% %f'

# HISTORY
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history
setopt histignorealldups histreduceblanks sharehistory appendhistory incappendhistory

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/bin

alias g='git'
alias t='tig'
alias dc='docker-compose'

function prof_branch_name_generator() {
    echo "feature/$1" | tr -d '(' | tr -d ')' | tr ' ' '-' | sed 's/--//g' | unaccent utf8
}