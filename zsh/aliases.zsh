alias q="exit"
alias today='date +%Y-%m-%d'
alias md="mkdir"

# list files and dirs
alias ls='eza --icons'
alias ll='ls -lh'
alias la='ll -a'
alias lz='la --sort size'     # sort files by file size
alias lt='la --sort modified' # sort files by modification time

alias cat='bat'
# count files
alias count='find . -type f | wc -l'

# copy with progress bar
alias cpv='rsync -ah --progress'

alias hl='hledger'
alias v='nvim'
alias vf='nvim $(fzf)'

find_files() {
	IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0 --prompt 'edit file: ' --preview='eza --tree --level=1 $(dirname {})'))
	[[ -n "$files" ]] && ${EDITOR} "${files[@]}"
}

# tmux aliases
alias tns='tmux new -s $(echo $(pwd) | xargs basename)'   # [t]mux [n]ew-[s]ession
alias tx=tmuxinator

# git aliases
alias g='git'
alias ga='git add'
alias gaa='git add -A'
alias gs='git status --short'
alias gst='git status'
alias gc='git commit -m'
alias gca='git commit -a -m'              # [g]it [c]ommit -[a] -m
alias gcm='git commit --amend -m'         # [g]it [c]ommit --amend -[m]
alias gcn='git commit --amend --no-edit'  # [g]it [c]ommit --amend --[n]o-edit
alias gb='git branch'
alias gbl=pretty_git_branch
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gco='git checkout'
alias co='git branch | cut -c 3- | gum filter | xargs git checkout' # prettier branch checkout
alias nb='git checkout -b'                                          # new branch
alias gd='git diff'
alias gds='git diff --staged'
alias gpl='git pull'
alias gpla='git pull --all -p'
alias gp='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias gpt='git push origin $(git rev-parse --abbrev-ref HEAD) --tags'
alias gpn='git push origin $(git rev-parse --abbrev-ref HEAD) --no-verify'
alias gpu='git push origin --set-upstream $(git rev-parse --abbrev-ref HEAD)'
alias gpf='git push --force origin $(git rev-parse --abbrev-ref HEAD)'
alias gmg='git merge'
alias gmc='git merge --continue'
alias gma='git merge --abort'
alias gr='git rebase'
alias grc='git add -A && git rebase --continue'
alias gra='git rebase --abort'
alias gl=pretty_git_log
alias gw='git worktree'
alias gwl='git worktree list'
alias gwa='git worktree add'
alias gwr='git worktree remove'
alias pr='gh pr create -a @me  -w'
alias gclean='git fetch --prune && git gc'

# gcap: commit all and push
gcap() {
    git commit -a -m $1
    git push
}

# gmerge: merge current branch to the given branch
gmerge() {
    branch=$(git rev-parse --abbrev-ref HEAD) && \
    echo "merging" $branch "to" $1
    git checkout $1 && \
    git merge $branch
}

# gsync: pull in latest changes on master/main branch
gsync() {
    echo 'checking out {{ Color "212" "" "main/master" }} branch and pulling latest changes...' | gum format -t template
    echo ""
    git checkout main
    output=$?
    [ $output -ne 0 ] && git checkout master
    git pull --all -p
    gclean
}

gwab() {
    git worktree add ../$1 -b $1
    cd ../$1
}

# gsr: gsync() + git rebase
sr() {
    branch=$(git rev-parse --abbrev-ref HEAD) && \
    echo 'saved branch: {{ Color "212" "" "'$branch'" }}' | gum format -t template

    gsync

    echo 'checking out: {{ Color "212" "" "'$branch'" }}' | gum format -t template
    git checkout $branch
    git rebase master
}

# [b]ranch [c]heck[o]ut
bco() {
  git branch --no-color --sort=-committerdate --format='%(refname:short)' | fzf --header 'git checkout' | xargs git checkout
}
# [p]ull request [c]heck[o]ut
pco() {
  gh pr list --author "@me" | fzf --header 'checkout PR' | awk '{print $(NF-5)}' | xargs git checkout
}

# suffix aliases (just typing the json filename in terminal will open it in vim)
alias -s json=vim

# global alias:
#  replace all occurrences of the alias name with the command
alias -g awsdumcred='AWS_SECRET_ACCESS_KEY=dummy_secret AWS_ACCESS_KEY_ID=dummy_key'

# source the zsh config file
alias sc='source $HOME/.zshrc'
# edit the zsh config file
alias ec='$EDITOR $HOME/.zshrc'

alias d='docker'
alias dps='docker ps'
alias dim='docker images'

# docker-compose
alias dc='docker-compose'
alias dco='docker-compose'
alias dcb='docker-compose build'
alias dce='docker-compose exec'
alias dcps='docker-compose ps'
alias dcrestart='docker-compose restart'
alias dcrm='docker-compose rm'
alias dcr='docker-compose run'
alias dcstop='docker-compose stop'
alias dcup='docker-compose up'
alias dcupb='docker-compose up --build'
alias dcupd='docker-compose up -d'
alias dcdn='docker-compose down'
alias dcl='docker-compose logs'
alias dclf='docker-compose logs -f'
alias dcpull='docker-compose pull'
alias dcstart='docker-compose start'
alias dck='docker-compose kill'

# Functions
#--------------------------------
# make dir and cd into it
mdcd() {
  mkdir -p -- "$1" && cd -P -- "$1"
}

# run a specific go test 
# TODO: delete if unused (last checked 8th Feb, 2022)
gtr() {
  go test -v -run $1 $2
}
