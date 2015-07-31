#
# /etc/bash.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#PS1='[\u@\h \W]\$ '
#PS1="\e[37m\W\e[34m >\e[00m "
PS1="\[\e[00;37m\]\W \[\e[0m\]\[\e[00;34m\]>\[\e[0m\]\[\e[00;37m\] \[\e[0m\]"
PS2='> '
PS3='> '
PS4='+ '

case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
                                                        
    ;;
  screen)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
    ;;
esac

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
export EDITOR=vim
alias spr="curl -F 'sprunge=<-' http://sprunge.us | xclip"
alias vi=vim
alias server="ssh -D 8080 itsback.at"
alias ls="ls --color"
alias pamcan="pacman"
alias update="pacman -Syu --ignore ncmpcpp,openbox; kerncheck"
alias ps="ps aux | grep -v "grep" | grep "
alias paste="xsel --clipboard | spr"

# OS X aliases for work laptop
# alias xclip="pbcopy"
# alias xsel="pbpaste"
# alias spr="curl -F 'sprunge=<-' http://sprunge.us | pbcopy"
# alias paste="pbpaste --clipboard | spr"
alias istanbul="istanbul cover ./node_modules/mocha/bin/_mocha --report lcovonly -- -R spec && cat ./coverage/lcov.info | ./node_modules/coveralls/bin/coveralls.js && rm -rf ./coverage"

export TERM=xterm-256color
export PYTHON=python2.7
FIGNORE=.class
