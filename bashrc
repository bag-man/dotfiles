
#
# /etc/bash.bashrc
#
xmodmap -e "keycode 96 = Insert Insert Insert"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Stop Ctl+S
stty -ixon

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
PKGFILE_PROMPT_INSTALL_MISSING=y
source /usr/share/doc/pkgfile/command-not-found.bash
source /usr/share/git/completion/git-prompt.sh

PROJECT=$(gcloud config get-value project)
WHITE="\[\e[1;37m\]"
BLUE="\[\e[1;34m\]"
RED="\[\e[1;31m\]"
PS1="$WHITE\W\$(__git_ps1 ' (%s)') $BLUEλ $WHITE"
PS2='> '
PS3='> '
PS4='+ '

prompt_cmd () {
  LAST_STATUS=$?
  history -a; history -c; history -r;
  if [[ $PROJECT == "a6s-dev" ]]; then
    COLOUR=$BLUE;
  else
    COLOUR=$RED;
  fi
  PS1="$WHITE\W\$(__git_ps1 ' (%s)') $COLOURλ $WHITE"
}

export PROMPT_COMMAND=prompt_cmd

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
alias cleanorphans="pacman -Rns $(pacman -Qtdq)"
alias explicit="pacman -Qet"
alias mirrors="sudo pacman-mirrors --fasttrack && sudo pacman -Syy"
alias json="python -m json.tool"
alias build="npm --silent run build"
alias test="npm --silent run test"
alias start="npm --silent run start"
alias nuke="rm -rf build node_modules/ && npm i && npm run build"
alias stage="gcloud config set project a6s-stage; export PROJECT=a6s-stage"
alias dev="gcloud config set project a6s-dev; export PROJECT=a6s-dev"


#alias dev="tsc-watch --onSuccess 'node --inspect ./build/bin/server.js'"
alias debug="tsc-watch --onSuccess 'node inspect ./build/bin/server.js'"
alias cleartestdb="PGPASSWORD=123 psql -U postgres -h localhost -d advinans -c 'DROP SCHEMA company_benefit_next_test CASCADE; CREATE SCHEMA company_benefit_next_test;'"
alias cleardb="PGPASSWORD=123 psql -U postgres -h localhost -d advinans -c 'DROP SCHEMA company_benefit_next CASCADE; CREATE SCHEMA company_benefit_next;'"
alias clearcdb="PGPASSWORD=123 psql -U postgres -h localhost -d advinans -c 'DROP SCHEMA company CASCADE; CREATE SCHEMA company;'"
alias test="npm run test --silent --"
alias psql="pgcli"

alias diff="git difftool -- ':!package-lock.json'"
alias show="git showtool"
alias stat="git status"
alias add="git add"
alias commit="git commit -v"
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
alias rebase="git rebase -i master"
alias clean="git clean -f"
alias log="fzf_log"
alias squash="git reset --soft HEAD~2 && git commit"
alias theirs="git merge --strategy-option theirs"
alias removelocal="git reset --hard @{u}"
alias amend="git commit --amend -C @"

export EDITOR=vim
export TERM=xterm-256color
export PYTHON=python2.7
export PATH=~/.npm-global/bin:/home/owg1/.gem/ruby/2.5.0/bin:$PATH

export HISTCONTROL=ignoredups:erasedups  
export HISTSIZE=-1
export HISTFILESIZE=-1
shopt -s histappend                      

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,*.swp,dist,*.coffee}/*" 2> /dev/null'
export FZF_ALT_C_COMMAND="bfs -type d -nohidden"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--bind J:down,K:up --reverse --ansi --multi'
bind -x '"\C-p": fvim'
bind -m vi-insert '"\C-x\C-e": edit-and-execute-command'

sf() {
  if [ "$#" -lt 1 ]; then echo "Supply string to search for!"; return 1; fi
  printf -v search "%q" "$*"
  include="tsx,vim,ts,yml,yaml,js,json,php,md,styl,pug,jade,html,config,py,cpp,c,go,hs,rb,conf,fa,lst,graphql"
  exclude=".config,.git,node_modules,vendor,build/,yarn.lock,*.sty,*.bst,*.coffee,dist"
  rg_command='rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always" -g "*.{'$include'}" -g "!{'$exclude'}/*"'
  files=`eval $rg_command $search | fzf --ansi --multi --reverse | awk -F ':' '{print $1":"$2":"$3}'`
  [[ -n "$files" ]] && ${EDITOR:-vim} $files
}

sfu() {
  if [ "$#" -lt 1 ]; then echo "Supply string to search for!"; return 1; fi
  printf -v search "%q" "$*"
  include="ts,yml,yaml,js,json,php,md,styl,pug,jade,html,config,py,cpp,c,go,hs,rb,conf,fa,lst"
  exclude=".config,.git,node_modules,vendor,build,yarn.lock,*.sty,*.bst,*.coffee,dist"
  rg_command='rg -m1 --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always" -g "*.{'$include'}" -g "!{'$exclude'}/*"'
  files=`eval $rg_command $search | fzf --ansi --multi --reverse | awk -F ':' '{print $1":"$2":"$3}'`
  [[ -n "$files" ]] && ${EDITOR:-vim} $files
}


fc() {
  hash=$(git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |  fzf | awk '{print $1}')
  git checkout $hash
}

gc() {
  hash=$(git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |  fzf | awk '{print $1}')
  gopen $hash
}

fzf_log() {
  hash=$(git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |  fzf | awk '{print $1}')
  echo $hash | xclip
  git showtool $hash
}

tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then 
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
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

c() {
  local cols sep google_history open
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  if [ "$(uname)" = "Darwin" ]; then
    google_history="$HOME/Library/Application Support/Google/Chrome/Default/History"
    open=open
  else
    google_history="$HOME/.config/google-chrome/Profile 1/History"
    open=xdg-open
  fi
  cp -f "$google_history" /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null
}

gopen() {
    project=$(git config --local remote.origin.url | sed s/git@github.com\:// | sed s/\.git//)
    url="http://github.com/$project/commit/$1"
    xdg-open $url
}

# [[ -s "/home/owg1/.gvm/scripts/gvm" ]] && source "/home/owg1/.gvm/scripts/gvm"

# export NVM_DIR="$HOME/.nvm"

# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

