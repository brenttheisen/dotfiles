# export SHELL=zsh # Commented out because it breaks ssh ProxyCommand for some reason
export EDITOR=vim
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH

# oh-my-zsh: Path to your oh-my-zsh configuration
ZSH=$HOME/.oh-my-zsh

# oh-my-zsh: Uncomment following line if you want to disable autosetting terminal title
DISABLE_AUTO_TITLE="true"

# Environment variables
export MANPATH="$(brew --prefix coreutils)/libexec/gnuman"
export JAVA_HOME=`/usr/libexec/java_home -v 11`
export SCALA_HOME=/usr/local/Cellar/scala/2.10.3
export ANDROID_SDK_ROOT=/Users/brent/Library/Android/sdk
export ANDROID_HOME=$ANDROID_SDK_ROOT
export LESS=' -R '
export DOCKER_HOST=unix:///var/run/docker.sock
export VAULT_SKIP_VERIFY=1

# oh-my-zsh: List of plugins to load
plugins=(git git-flow vi-mode per-directory-history brew mvn ssh-agent docker aws history-substring-search jsontools pass)

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

# circleci zsh aliases
alias ci='open "https://circleci.com/gh/`ghorg`/`ghrepo`/tree/`gbc`"'
alias calls='open "https://coveralls.io/github/`ghorg`/`ghrepo`?branch=`gbc`"'

# rails zsh aliases
alias rdbm='rake db:migrate db:test:clone'

# docker aliases
alias drcnr='docker rm $(docker ps -a -q)'
alias drint='docker rmi $(docker images | grep "^<none>" | awk "{print $3}")'
alias drun='docker run -i -t $*'
alias dc='docker-compose'

# aws-vault aliases
alias aveda='aws-vault exec devs aws -- '
alias avld='aws-vault login devs'

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

# powerline
export PATH=$PATH:~/Library/Python/3.8/bin
source ~/Library/Python/3.8/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh

# Set final PATH
export PATH=$HOME/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$(/opt/homebrew/bin/brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$ANDROID_HOME/tools/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:~/Library/Python/3.8/bin

# rbenv
eval "$(rbenv init - zsh)"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/brent/tmp/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/brent/tmp/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/brent/tmp/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/brent/tmp/google-cloud-sdk/completion.zsh.inc'; fi

# AWS Vault
export AWS_SESSION_TOKEN_TTL=24h
export AWS_FEDERATION_TOKEN_TTL=24h
