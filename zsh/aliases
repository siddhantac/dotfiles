# list files and dirs
alias ls='exa --icons'
alias ll='ls -lh'
alias la='ll -a'

# sort files by file size
alias lz='la --sort size'

# sort files by modification time
alias lt='la --sort modified'

# count files
alias count='find . -type f | wc -l'

# copy with progress bar
alias cpv='rsync -ah --progress'

# git aliases
alias ga='git add'
alias gaa='git add -A'
alias gs='git status --short'
alias gst='git status'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit -a -m' 
alias gcmm='git commit --amend -m'
alias gcmn='git commit --amend --no-edit' 
alias gb='git branch'
alias gbl=pretty_git_branch
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gco='git checkout'
alias gd='git diff'
alias gds='git diff --staged'
alias gpl='git pull'
alias gpla='git pull --all -p'
alias gp='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias gpn='git push origin $(git rev-parse --abbrev-ref HEAD) --no-verify'
alias gpu='git push origin --set-upstream $(git rev-parse --abbrev-ref HEAD)'
alias gmg='git merge'
alias gmc='git merge --continue'
alias gma='git merge --abort'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias gl=pretty_git_log

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
    echo 'checking out the {{ Color "212" "" "main/master" }} branch and pulling latest changes...' | gum format -t template
    git checkout master
    output=$?
    [ $output -ne 0 ] && git checkout main
    git pull --all -p
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
