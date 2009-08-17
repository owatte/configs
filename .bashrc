PATH=$PATH:/usr/local/cuda/bin:/usr/games
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib
export PATH
export LD_LIBRARY_PATH
alias scheme='mzscheme'
alias ls="ls -x -X --color=always"

complete -cf sudo
source ~/.git-completion.bash
