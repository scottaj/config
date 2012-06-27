#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

#export GEM_HOME=/usr/lib/ruby/gems/1.9.1
export EDITOR='emacsclient -t -a "" -c'
export SHELL='/bin/bash -l'
PYTHONDOCS=/usr/share/doc/python/html/

export HISTCONTROL=erasedups
export HISTSIZE=500
export HISTIGNORE=ls:'ls -l':fg
#export EDITOR='mvim -f --remote-silent'
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

alias pkgsync='yes | sudo pacman -S'
alias pkgsync-all='sudo pacman -Syu'
alias pkgsearch='pacman -Ss'
alias pkginfo='pacman -Qil'
alias pkgdump='yes | sudo pacman -Rs'
alias pkgtrash='sudo pacman -Rsc'
alias lampadmin='ssh svr-boss@scottaj2.dlinkddns.com -i /home/alexander/.ssh/desktop_key'
#alias gem='sudo gem'
alias clojure='clj'
alias emacsc='emacsclient -t -a "" -c'
#alias emacs='emacsclient -t -a ""'
alias rc.d='sudo rc.d'
alias editor='emacsclient -t -a "" -c'


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
