alias q="exit"
alias today='date +%Y-%m-%d'
alias md="mkdir"

alias puffin='puffin -cfg ~/workspace/bin/config.json'

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

find_files() {
	# IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0 --prompt 'edit file: ' --preview='eza --tree --level=1 $(dirname {})'))
	IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0 --prompt 'edit file: ' --preview='bat {} --color=always'))
	[[ -n "$files" ]] && ${EDITOR} "${files[@]}"
}
alias vf='find_files'

# fzf browse directories and cd into them
find_dir() {
	local dir
	dir=$(fd -IH -t d -E '.git' 2> /dev/null | fzf --prompt 'go to: ' +m --preview-window='right:50%:nohidden:wrap' --preview='eza --tree --level=2 {}') && cd "$dir"
}

# paginate help
help() { "$@" --help | bat -l man -p ; }

# quick commit all
qc(){
	[[ ! "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]] && { echo "not a git repo"; return; }

	local unstaged_list="$(git status -s)"
	if [[ -z "$unstaged_list" ]]; then
		echo "no files to commit"
		return
	fi

	gum style --border rounded --foreground "#d33682" --border-foreground "#2aa198" --margin "1 1" --padding "1 1" $unstaged_list

	local message=$(gum input --prompt="commit: " --placeholder="commit message...")

	if [[ -z "$message" ]]; then
		echo "commit aborted"
		return
	fi

	gum confirm "add files and commit?" && \
	git add . && git commit -m "$message" && \
	gum confirm "push to $(git rev-parse --abbrev-ref --symbolic-full-name @{u})?" && gum spin --spinner dot --title "git push..." --show-output -- git push
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
# alias gb='git branch'
alias gb=pretty_git_branch_sorted
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gco='git checkout'
alias ghd=show_git_head
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
alias gpf='git push --force-with-lease origin $(git rev-parse --abbrev-ref HEAD)'
alias gmg='git merge'
alias gmc='git merge --continue'
alias gma='git merge --abort'
alias gr='git rebase'
alias grc='git add -A && git rebase --continue'
alias gra='git rebase --abort'
alias gl=pretty_git_log
alias gla=pretty_git_log_all
alias gw='git worktree'
alias gwl='git worktree list'
alias gwa='git worktree add'
# alias gwr='git worktree remove'
alias pr='gh pr create -a @me  -w'
alias gclean='git fetch --prune && git gc'

# gwr: remove worktree
gwr() {
    if [[ -z "$1" ]]; then
        git worktree list | awk '{print $1}' | fzf | xargs -I {} git worktree remove {}
    else
        git worktree remove $1
    fi
}

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

# [p]ull remote [b]ranch
pb() {
    git branch --remote --no-color --sort=-committerdate --format='%(refname:short)' | fzf --header 'git checkout' | rg '(.*)/(.*)' -or '$2' | xargs git checkout
  # git branch --remote --no-color --sort=-committerdate --format='%(refname:short)' | fzf --header 'git checkout' | xargs git checkout
}

# [b]ranch [c]heck[o]ut
bco() {
  git branch --no-color --sort=-committerdate --format='%(refname:short)' | fzf --header 'git checkout' | xargs git checkout
}
# [p]ull request [c]heck[o]ut
pco() {
  gh pr list --author "@me" | fzf --header 'checkout PR' | awk '{print $1}' | xargs gh pr checkout
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

# preview files
pf() {
	local selection
	if [[ -z "$1" ]]; then
		selection="$(fd -u -t f -E '.git/' | fzf)" && preview_files "$selection"
		return 0
	fi

	case $1 in
		-e)
        # 2024-09-17 not using this
			shift
			selection="$(fd -u -t f -E '.git/' -e $1 | fzf --multi --select-1 --exit-0 | tr '\n' ' ')"
			[[ -n "$selection" ]] && preview_files "${(z)selection}"
			shift
			;;
		-t)
        # 2024-09-17 not using this
			bat --style='grid' ~/.todo;;
		*.md)
			glow -p $@;;
		*.json)
			jq '.' -C $1 | less -R;;
		*.csv)
			vd "$@";;
		*.pdf)
			zathura $1;;
		*)
			if [[ -f $1 ]]; then
				bat --style='header,grid' $1
			else
				which $1 | bat -l sh --style 'grid'
			fi
	esac
}

# open PRs in nvim diffview
nvim_diff() {
	[[ ! "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]] && { echo "not a git repo"; return; }

	local branches="$(git branch -a --format='%(refname:short)' | grep -v 'HEAD' |
		fzf -d' ' \
		--prompt="branches:" \
		--preview="git log --oneline --format='%C(bold blue)%h%C(reset) - %C(green)%ar%C(reset) - %C(cyan)%an%C(reset)%C(bold yellow)%d%C(reset): %s' --color=always {}" \
		--header=$'\n' \
		--no-info
	)"

	if [[ -n "$branches" ]]; then
		nvim +"DiffviewOpen $branches" +tabonly
	fi
}
