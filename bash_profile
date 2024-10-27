#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
export PATH="/home/owg1/.local/bin:$PATH"
# https://github.com/White-Oak/arch-setup-for-dummies/blob/master/setting-up-ssh-agent.md
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

