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
# Suppress ssh-agent plugin console output to prevent Powerlevel10k instant prompt warnings
zstyle :omz:plugins:ssh-agent quiet yes
source $ZSH/oh-my-zsh.sh

# 4. CORE TOOL CONFIG
bindkey -v # Vi Mode
if [ -x /usr/libexec/path_helper ]; then
  eval `/usr/libexec/path_helper -s`
fi

# 5. ALIASES
alias vi=nvim
alias vim='stty start undef stop undef; nvim'
alias ts='date +"%Y%m%d%H%M%S"'
alias p='ping 8.8.8.8'
alias grr='grep -Rn'
alias ctags="$(brew --prefix)/bin/ctags"

# 6. FINAL SOURCES
[[ -a ~/.zshrc.secure ]] && source ~/.zshrc.secure
eval "$(rbenv init - zsh)"
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
