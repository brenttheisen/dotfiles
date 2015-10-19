# export SHELL=zsh # Commented out because it breaks ssh ProxyCommand for some reason
export EDITOR=vim

# oh-my-zsh: Path to your oh-my-zsh configuration
ZSH=$HOME/.oh-my-zsh

# oh-my-zsh: Uncomment following line if you want to disable autosetting terminal title
DISABLE_AUTO_TITLE="true"

# oh-my-zsh: List of plugins to load
plugins=(git git-flow rails rake rvm vi-mode per-directory-history brew mvn ssh-agent vagrant virtualbox docker scala sbt aws)

source $ZSH/oh-my-zsh.sh

# Environment variables
export DSE_HOME=/opt/dse
export MANPATH="$(brew --prefix coreutils)/libexec/gnuman"
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export SCALA_HOME=/usr/local/Cellar/scala/2.10.3
export ANDROID_SDK_ROOT=/usr/local/opt/android-sdk
export ANDROID_HOME=$ANDROID_SDK_ROOT
export LESSOPEN="| src-hilite-lesspipe.sh %s"
export LESS=' -R '
export DOCKER_HOST=tcp://127.0.0.1:2375
export VAULT_ADDR=https://hashivault-1.internal.womply.com:8200

# zsh: Vi Mode
bindkey -v

# zsh: Syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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
alias gwb='git browse OtoAnalytics/Womply'
alias gwbc='git browse OtoAnalytics/Womply commit/'
alias gbc='git rev-parse --abbrev-ref HEAD'

# github zsh aliases
alias ghorg="git remote -v | grep -E '^origin.*\(push\)$' | sed -n 's/^.*git\@github\.com\:\(.*\)\/.*$/\1/p'"
alias ghrepo="git remote -v | grep -E '^origin.*\(push\)$' | sed -n 's/^.*\/\(.*\)\.git.*$/\1/p'"

# circleci zsh aliases
alias ci='open "https://circleci.com/gh/`ghorg`/`ghrepo`/tree/`gbc`"'

# rails zsh aliases
alias rdbm='rake db:migrate db:test:clone'

# pass zsh aliases
alias pwprod='pass -c Womply/SSH/Prod'
alias pwpre='pass -c Womply/SSH/Preprod'
alias pwawsproper='pass -c Womply/AWS/Proper'
alias pwawsbrent='pass -c Womply/AWS/Brent'
alias pwawsdev='pass -c Womply/AWS/WomplyDev'

# docker aliases
alias docker="docker --tlsverify=false"
alias drcnr='docker rm $(docker ps -a -q)'
alias drint='docker rmi $(docker images | grep "^<none>" | awk "{print $3}")'
alias drun='docker run -i -t $*'

# other zsh aliases
alias ctags="`brew --prefix`/bin/ctags"
alias vim='stty start undef stop undef ; vim'
alias tc='tmux_copy'
alias ts='date +"%Y%m%d%H%M%S"'

# powerline
. /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

# Fix for man pages
if [ -x /usr/libexec/path_helper ]; then
  eval `/usr/libexec/path_helper -s`
fi

export PATH=$HOME/bin:$HOME/.rvm/bin:/usr/local/bin:/usr/local/sbin:$(/usr/local/bin/brew --prefix coreutils)/libexec/gnubin:/usr/bin:/bin:/usr/sbin:/sbin:$DSE_HOME/bin:/opt/opscenter/bin:$PATH

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 

# boot2docker
# $(boot2docker shellinit 2> /dev/null)

# or... docker-machine
export DOCKER_MACHINE_NAME=default
boot2docker() {
  if [ "$1" = "ip" ]; then
    docker-machine ip $DOCKER_MACHINE_NAME
  else
    command boot2docker "$@"
  fi
}

# docker-machine start $DOCKER_MACHINE_NAME 2>&1 > /dev/null
eval $(docker-machine env $DOCKER_MACHINE_NAME 2>&1 > /dev/null)
