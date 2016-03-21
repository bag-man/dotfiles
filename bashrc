#
# /etc/bash.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
source /usr/share/git/completion/git-prompt.sh
source /usr/share/doc/pkgfile/command-not-found.bash

WHITE="\[\e[1;37m\]"
BLUE="\[\e[1;34m\]"
PS1="$WHITE\W\$(__git_ps1 ' (%s)') $BLUE> $WHITE"
PS2='> '
PS3='> '
PS4='+ '

alias spr="curl -F 'sprunge=<-' http://sprunge.us | xclip"
alias vi=vim
alias pamcan="pacman"
alias paste="xsel --clipboard | spr"
alias ls="ls -lah --color"

alias diff="git difftool"
alias show="git showtool"
alias stat="git status"
alias log="git log"
alias add="git add"
alias commit="git commit"
alias branch="git branch"
alias push='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias check="git checkout"
alias stash="git stash"
alias pop="git stash pop"
alias pull="git pull"
alias clone="git clone"
alias merge="git merge"
alias cherry="git cherry-pick"
alias last="git difftool HEAD^ HEAD"
alias fetch="git fetch"
alias revert="git revert"
alias bisect="git bisect"
alias reflog="git reflog"
alias apply="git apply"

function reset() {
  git reset --hard HEAD~$1
}

export EDITOR=vim
export TERM=xterm-256color
export PYTHON=python2.7
export HISTSIZE=""
