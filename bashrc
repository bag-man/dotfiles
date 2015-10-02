#
# /etc/bash.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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
alias ls="ls --color"
alias pamcan="pacman"
alias ps="ps aux | grep -v "grep" | grep "
alias paste="xsel --clipboard | spr"

export TERM=xterm-256color
export PYTHON=python2.7
