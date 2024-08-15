# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# export SHELL=zsh # Commented out because it breaks ssh ProxyCommand for some reason
export EDITOR=nvim
alias vi=nvim

export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH

# oh-my-zsh: Path to your oh-my-zsh configuration
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"

# oh-my-zsh: Uncomment following line if you want to disable autosetting terminal title
DISABLE_AUTO_TITLE="true"

# Environment variables
export MANPATH="$(brew --prefix coreutils)/libexec/gnuman"
# export JAVA_HOME=`/usr/libexec/java_home -v 11`
export SCALA_HOME=/usr/local/Cellar/scala/2.10.3
export ANDROID_SDK_ROOT=/Users/brent/Library/Android/sdk
export ANDROID_HOME=$ANDROID_SDK_ROOT
export LESS=' -R '
export DOCKER_HOST=unix:///var/run/docker.sock
export VAULT_SKIP_VERIFY=1

# Find process listening on a port
psport() {
    if [ $# -eq 0 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P
    elif [ $# -eq 1 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color $1
    else
        echo "Usage: listening [pattern]"
    fi
}

# oh-my-zsh: List of plugins to load
plugins=(git git-flow vi-mode per-directory-history brew mvn ssh-agent docker aws history-substring-search jsontools pass zsh-nvm)

source $ZSH/oh-my-zsh.sh

# zsh: Vi Mode
bindkey -v

# hub: Allow hub to work in git
eval "$(hub alias -s)"

# git zsh aliases
function last_deploy_production_tag() {
  tag=$(git tag 2> /dev/null | grep deploy_production_ | sort | tail -1) || return
  echo ${tag}
}

# git zsh aliases
alias gpr='git pull-request'
compdef _git gpr='git pull-request'
alias gcmp='git compare'
compdef _git gcmp='git compare'
alias gbpush='git push -u brenttheisen $(current_branch)'
compdef gbpush=git
alias gwddep='git diff $(last_deploy_production_tag)..master'
alias gwcmpdep='git compare $(last_deploy_production_tag)..master'
alias gbc='git rev-parse --abbrev-ref HEAD'

# github zsh aliases
alias ghorg="git remote -v | grep -E '^origin.*\(push\)$' | sed -n 's/^.*git\@github\.com\:\(.*\)\/.*$/\1/p'"
alias ghrepo="git remote -v | grep -E '^origin.*\(push\)$' | sed -n 's/^.*\/\(.*\)\.git.*$/\1/p'"

# docker aliases
alias drcnr='docker rm $(docker ps -a -q)'
alias drint='docker rmi $(docker images | grep "^<none>" | awk "{print $3}")'
alias drun='docker run -i -t $*'
alias dc='docker-compose'

# aws-vault aliases
AWS_VAULT_PROFILE="319448201427:brent"
alias aved='aws-vault exec $AWS_VAULT_PROFILE -- '
alias aveda='aved aws '
alias avld='aws-vault login $AWS_VAULT_PROFILE'

# other zsh aliases and functions
alias ctags="`brew --prefix`/bin/ctags"
alias vim='stty start undef stop undef ; vim'
alias tc='tmux_copy'
alias ts='date +"%Y%m%d%H%M%S"'
function mvnim() {
  mvn clean install -pl "$1" -am
}

# Jira stuff
alias j='f() { open https://${JIRA_ORG_HOSTNAME}.atlassian.net/browse/$1 };f'
alias jb='j $(current_branch)'

# Pass aliases
alias pw='pass '
alias pwc='pass -c '

# Github Copilot
alias ghc='gh copilot'

# Misc aliases
alias p='ping 8.8.8.8'
alias grr='grep -Rn'

# Fix for man pages
if [ -x /usr/libexec/path_helper ]; then
  eval `/usr/libexec/path_helper -s`
fi

if [[ -a ~/.zshrc.secure ]]; then
  source ~/.zshrc.secure
fi

# Install nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
# [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
NODE_VER='default'
# nvm use $NODE_VER

# zsh: Syntax highlighting (this must be at the end)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Set final PATH
export PATH=$HOME/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$(/opt/homebrew/bin/brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin

# rbenv
# eval "$(rbenv init - zsh)"

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/brent/tmp/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/brent/tmp/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
# if [ -f '/Users/brent/tmp/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/brent/tmp/google-cloud-sdk/completion.zsh.inc'; fi

# AWS Vault
export AWS_SESSION_TOKEN_TTL=24h
export AWS_FEDERATION_TOKEN_TTL=24h

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
