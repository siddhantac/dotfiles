
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'

# sort files by file size
alias lt='ls -h --size -1 -S --classify'

# sort files by modification time
alias lf='ls -t -1'

# count files
alias count='find . -type f | wc -l'

# copy with progress bar
alias cpv='rsync -ah --info=progress2'

# find command in history
alias gh='history|grep'
