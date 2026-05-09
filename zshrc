# 1. P10K INSTANT PROMPT (Must stay at the top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# 2. ENVIRONMENT VARIABLES & PATH
export EDITOR=nvim
export DOCKER_HOST=unix:///var/run/docker.sock

# Use Zsh array for PATH (easier to read/modify)
typeset -U path
path=(
  $HOME/bin
  $HOME/.local/bin
  /opt/homebrew/bin
  /opt/homebrew/sbin
  /opt/homebrew/opt/coreutils/libexec/gnubin
  ~/.docker/cli-plugins
  /usr/local/bin
  /usr/local/sbin
  $path
)

export MANPATH="/opt/homebrew/opt/coreutils/libexec/gnuman:$MANPATH"

# 3. OH-MY-ZSH CONFIGURATION
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
DISABLE_AUTO_TITLE="true"
plugins=(
  git gitfast vi-mode per-directory-history brew
  ssh-agent docker aws history-substring-search jsontools pass nvm
)
source $ZSH/oh-my-zsh.sh

# 4. CORE TOOL CONFIG
bindkey -v # Vi Mode
eval "$(hub alias -s)"
if [ -x /usr/libexec/path_helper ]; then
  eval `/usr/libexec/path_helper -s`
fi

# 5. ALIASES
# General
alias vi=nvim
alias vim='stty start undef stop undef; nvim'
alias tc='tmux_copy'
alias ts='date +"%Y%m%d%H%M%S"'
alias p='ping 8.8.8.8'
alias grr='grep -Rn'
alias ctags="$(brew --prefix)/bin/ctags"

# Git
alias gpr='git pull-request'
alias gcmp='git compare'
alias gbpush='git push -u brenttheisen $(current_branch)'
alias gwddep='git diff $(last_deploy_production_tag)..master'
alias gwcmpdep='git compare $(last_deploy_production_tag)..master'
alias gbc='git rev-parse --abbrev-ref HEAD'
compdef _git gpr='git pull-request'
compdef _git gcmp='git compare'
compdef gbpush=git

# Jira
j() {
  open "https://${JIRA_ORG_HOSTNAME}.atlassian.net/browse/$1"
}
jb() {
  j $(current_branch)
}

# 7. FINAL SOURCES
[[ -a ~/.zshrc.secure ]] && source ~/.zshrc.secure
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
