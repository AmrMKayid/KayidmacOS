#--------------- Udacity Style ---------------#
# Enable tab completion
source ~/git-completion.bash

# colors!
green="\[\033[0;32m\]"
blue="\[\033[0;34m\]"
purple="\[\033[0;37m\]"
reset="\[\033[0m\]"

# Change command prompt
source ~/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
# '\u' adds the name of the current user to the prompt
# '\$(__git_ps1)' adds git-related stuff
# '\W' adds the name of the current directory
export PS1="$purple\u$green\$(__git_ps1)$blue \W $ $reset"

export PATH=~/.local/bin:$PATH
export PATH="/usr/local/bin:$PATH"

# Make pyenv Python default
# Add the following to your ~/.bash_profile
# We want to load pyenv every time we open a new shell
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# Adding Ruby
eval "$(rbenv init -)"

export NVM_DIR="/Users/amrmkayid/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# added by Anaconda3 5.1.0 installer
export PATH="/Users/amrmkayid/anaconda3/bin:$PATH"

#export PATH="$PATH:/Library/PostgreSQL/10/bin:$PATH"

#--------------- Aliases ---------------#
alias ds='cd Desktop/'
alias proxy='export http_proxy="http://amr.kayid:<P@55w0rd>@50.0.0.5:8080/"; export https_proxy="http://amr.kayid:<P@55w0rd>@50.0.0.5:8080/"; export ftp_proxy="http://amr.kayid:<P@55w0rd>@50.0.0.5:8080/";'

alias nawwar='nodemon --exec npm run dev'
alias nawwarBack='nodemon --exec npm run devBack'
alias py3='/Users/amrmkayid/.pyenv/shims/python3'

## git
alias gi='git init && cp /Users/amrmkayid/.gitignore . &&  touch README.md && git add . && git commit -m "Initial commit"'