# Symfony
alias sf="php $(find . -maxdepth 2 -mindepth 1 -name 'console' -type f | head -n 1)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion (node is in path now)

# Set language to English
export LC_ALL=C

# Workspace
alias workspace='cd /Volumes/workspace'

source ~/.git-prompt
