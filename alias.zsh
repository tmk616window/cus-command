
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH="$PATH:/opt/homebrew/bin/"

alias g='git'
alias status='git status'
alias push='git push origin $(git branch | sed -r "s/^[ \*]+//" | peco)'
alias add='git add'
alias diff='git diff'
alias commit='git commit'
alias co='git checkout $(git branch | sed -r "s/^[ \*]+//" | peco)'
alias cob='git checkout -b'
alias log='git log'
alias pull='git pull origin $(git branch | sed -r "s/^[ \*]+//" | peco)'
alias clone='git clone'
alias branch='`git branch | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'

alias dcp='docker compose ps'
alias dcb='docker compose build'
alias dcu='docker compose up'
alias dcd='docker compose down'
alias dce='docker compose exec'

alias m='make'

alias ch='peco-select-history'
# peco settings
# 過去に実行したコマンドを選択。ctrl-rにバインド
function peco-select-history() {
    =$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# search a destination from cdr list
function peco-get-destination-from-cdr() {
  cdr -l | \
  sed -e 's/^[[:digit:]]*[[:blank:]]*//' | \
  peco --query "$LBUFFER"
}

### 過去に移動したことのあるディレクトリを選択。ctrl-uにバインド
function peco-cdr() {
  local destination="$(peco-get-destination-from-cdr)"
  if [ -n "$destination" ]; then
    BUFFER="cd $destination"
    zle accept-line
  else
    zle reset-prompt
  fi
}
zle -N peco-cdr
bindkey '^u' peco-cdr

# ブランチを簡単切り替え。git checkout lbで実行できる
alias branch='`git branch | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'

# dockerコンテナに入る。deで実行できる
alias de='docker exec -it $(docker ps | peco | cut -d " " -f 1) /bin/bash'
