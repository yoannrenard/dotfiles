# Set language to English
export LC_ALL=C.UTF-8
export PATH="$HOME/.local/bin:$PATH"

alias sf="php $(find . -maxdepth 2 -mindepth 1 -name 'console' -type f | head -n 1)"
alias workspace='cd /Volumes/workspace'
alias highlite='cd /Volumes/workspace/highlite'
alias ll="ls -la"

source ~/.git-prompt
source ~/.npm-prompt
