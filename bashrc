#
# /etc/bash.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Stop Ctl+S
stty -ixon

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
PKGFILE_PROMPT_INSTALL_MISSING=y
source /usr/share/doc/pkgfile/command-not-found.bash
source /usr/share/git/completion/git-prompt.sh

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
alias ls="ls -lah --color --group-directories-first"
alias entr="find . -not -path './node_modules/*' -not -name '*.swp' | entr sh -c"
alias where="bfs ./ -name "
alias rg="rg -p"
alias less="less -R"
alias orphans="pacman -Qdt"
alias explicit="pacman -Qet"

alias diff="git difftool"
alias show="git showtool"
alias stat="git status"
alias add="git add"
alias commit="git commit"
alias push='git push -u origin $(git rev-parse --abbrev-ref HEAD)'
alias check="git checkout"
alias stash="git stash -u"
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
alias reset="git reset"
alias squash="git reset --soft "
alias clean="git clean -f"
alias log="fzf_log"

export EDITOR=vim
export TERM=xterm-256color
export PYTHON=python2.7
export PATH=~/.npm-global/bin:$PATH

export HISTCONTROL=ignoredups:erasedups  
export HISTSIZE=100000                   
export HISTFILESIZE=100000               
shopt -s histappend                      
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,*.swp,dist,*.coffee}/*" 2> /dev/null'
export FZF_ALT_C_COMMAND="bfs -type d -nohidden"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--bind J:down,K:up --reverse --ansi '
bind -x '"\C-p": fvim'

sf() {
  rg_command='rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always" -g "*.{js,json,php,md,styl,pug,jade,html,config,py,cpp,c,go,hs,rb,conf,fa,lst}" -g "!{.config,.git,node_modules,vendor,build,yarn.lock,*.sty,*.bst,*.coffee,dist}/*"'
  local files=`eval $rg_command $1 | fzf | awk -F ':' '{print $1":"$2":"$3}'`
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

fzf_log() {
  hash=$(git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |  fzf | awk '{print $1}')
  echo $hash | xclip
  git showtool $hash
}

tm() {
  local session
  newsession=${1:-new}
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --query="$1" --select-1 --exit-0) &&
    tmux attach-session -t "$session" || tmux new-session -s $newsession
}

branch() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

fvim() {
  local IFS=$'\n'
  local files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}
