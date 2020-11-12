##### a few snippets from the default debian bashrc

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


#### user edits

# local scripts
export PATH="$HOME/.local/bin/:$PATH"

# version managers
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.tfenv/bin:$PATH"
eval "$(rbenv init -)"

# security
export GPG_TTY=$(tty)

# AWS Tooling
complete -C aws_completer aws
export AWS_VAULT_KEYCHAIN_NAME=login
eval "$(aws-vault --completion-script-bash)"

# Docker
export DOCKER_BUILDKIT=1

# Terminal support
source /dev/stdin <<<"$(kitty + complete setup bash)"

# Editors
export VISUAL=vim
export EDITOR="$VISUAL"

# git
source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWCOLORHINTS=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true

# Auth tokens
export COMPOSER_AUTH="{\"github-oauth\":$(composer config -g github-oauth)}"
export NPM_TOKEN="$(grep registry.npmjs.org ~/.npmrc | cut -d '=' -f2)"

# Bash
export PROMPT_COMMAND='__git_ps1 "\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\n" "\\\$ "'
HISTSIZE=5000
HISTFILESIZE=10000
set -o vi
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
complete -C terraform terraform
source <(helm completion bash)
