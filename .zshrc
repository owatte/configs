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


export TERM=xterm-256color
export EDITOR='emacsclient -t'
export ALTERNATE_EDITOR=emacs

alias em='emacsclient -t'
alias scheme='mzscheme'
alias ls="ls -x -X --color=always"

PROMPT="%n@`hostname`:%~ $ "

function precmd()
{
    # Adjust this to your current preferred prompt
    RPROMPT=""
    local _git _branch

    # This call requires the "findup" script from http://www.davidfaure.fr/scripts
    _git=`findup .git`

    if test -n "$_git"; then
        _branch=`sed -e 's,.*/,,' $_git/HEAD`
        RPROMPT="branch: ($_branch)"
    fi

    # Add final character after the optional git branch (usually # or >)
}

