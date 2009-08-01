PATH=$PATH:/usr/local/cuda/bin:/usr/games
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib
export PATH
export LD_LIBRARY_PATH
alias scheme='mzscheme'
alias ls="ls -x -X --color=always"

if [ "$PS1" ]; then
    # Disables the bloody CapsLock button
    xmodmap -e "remove lock = Caps_Lock"
fi

source ~/.git-completion.bash
