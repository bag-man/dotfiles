#
# /etc/bash.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
source /usr/share/git/completion/git-prompt.sh

WHITE="\[\e[1;37m\]"
BLUE="\[\e[1;34m\]"
PS1="$WHITE\W\$(__git_ps1 ' (%s)') $BLUE> $WHITE"
PS2='> '
PS3='> '
PS4='+ '

export EDITOR=vim
alias spr="curl -F 'sprunge=<-' http://sprunge.us | xclip"
alias vi=vim
alias pamcan="pacman"
alias ps="ps aux | grep -v "grep" | grep "
alias paste="xsel --clipboard | spr"
alias ls="ls -lah --color"

alias diff="git difftool"
alias show="git showtool"
alias stat="git status"
alias log="git log"
alias add="git add"
alias branch="git branch"
alias reset="git reset"
alias commit="git commit"
alias push="git push origin $(git rev-parse --abbrev-ref HEAD)"
alias check="git checkout"

export TERM=xterm-256color
export PYTHON=python2.7
