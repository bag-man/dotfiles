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
# PS1="\[\e[00;37m\]\W \[\e[0m\]\[\e[00;34m\]>\[\e[0m\]\[\e[00;37m\] \[\e[0m\]"
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
alias diff="git difftool -x 'icdiff --line-numbers' -y | less -R"

export TERM=xterm-256color
export PYTHON=python2.7
