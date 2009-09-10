# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt notify
setopt autopushd
setopt pushdignoredups
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/numix/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
export TERM=xterm

alias scheme='mzscheme'
alias ls="ls -x -X --color=always"

alias tv='DISPLAY=:0.1'