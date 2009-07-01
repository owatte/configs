# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt notify
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/numix/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


alias scheme='mzscheme'
alias simcity="wine ~/.wine/drive_c/Program\ Files/Maxis/SimCity\ 4\ Deluxe/SimCity\ 4.exe"
alias "ls"="ls -x -X --color=always"
alias wcam="LD_PRELOAD=/usr/lib/libv4l/v4l1compat.so"

