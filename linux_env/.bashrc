
# tmux as default
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  tmux attach -t default || tmux new -s default || echo 'could not open tmux'
fi

# environment
# export WSLENV=$WSLENV:LOG_OUTPUT/p
DEV_ENV='/mnt/d/dev'
export DOCKER_VOLUMES='/mnt/d/docker/volumes'

# ignoring history duplicate
export HISTCONTROL=ignoreboth

# ---------------------
# bash configs
# ---------------------

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
	# Ensure existing Homebrew v1 completions continue to work
	export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d";
	source "$(brew --prefix)/etc/profile.d/bash_completion.sh";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null; then
	complete -o default -o nospace -F _git g;
fi;

# ---------------------
# aliases
# ---------------------
alias q='exit'
alias c='clear'
alias h='history'
alias pd='pwd'
alias mkdir='mkdir -p'
alias ls='ls --color=auto'
alias lsl='ls -halt --group-directories-first --color=auto'
alias diff='colordiff'
alias pd='pwd'
alias vi='vim'
alias null='/dev/null'
alias apt-search='apt-cache search'
alias grep='grep --color=auto'
alias python=python3
alias pip=pip3
alias clip='xclip -sel clip'
alias goto='z'

# --------------------
# docker
# --------------------
function dk-up-fn {
  docker-compose -f $1 up -d
}

function dk-down-fn {
  docker-compose -f $1 down
}

alias dk-ps=docker-pretty-ps
alias dk-up=dk-up-fn
alias dk-down=dk-down-fn

# ---------------------
# paths
# ---------------------
alias q='exit'
alias home='cd ~'
alias root='cd /'
alias o=xdg-open
alias ..='cd ..'
alias ...='cd ..; cd ..'
alias ....='cd ..; cd ..; cd ..'

mkd () {
    mkdir -p -- "$1" &&
    cd -P -- "$1"
}

# --------------
#  inoa
# --------------
alias inoa-vpn='sudo openvpn --config /etc/secrets/inoa-vpn-g2-beta2.ovpn --auth-user-pass /etc/secrets/vpn-pwd --daemon'

# ---------------------
# customize env
# ---------------------
alias vimrc='vim ~/.vimrc'
alias bashrc='vim ~/.bashrc'
alias bash-refresh='source ~/.bashrc'

# ---------------------
# env config
# ---------------------
# export GREP_OPTIONS=' — color=auto'
export VISUAL=vim
export EDITOR="$VISUAL"

# ---------------------
# stats
# --------------------
function count-lines {
  find . -name "*.$1" | xargs wc -l
}

# ---------------------
# powerline
# --------------------
export PATH=$PATH:$HOME/.local/bin

if [ -f $HOME/.local/lib/python3.9/site-packages/powerline/bindings/bash/powerline.sh ]; then
  $HOME/.local/bin/powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  source $HOME/.local/lib/python3.9/site-packages/powerline/bindings/bash/powerline.sh
fi

# ---------------------
# poetry
# --------------------
PATH=$PATH:$HOME/.poetry/bin

# ---------------------
# z
# --------------------
. ~/apps/z/z.sh

# ---------------------
# LS_COLORS
# ---------------------
export LS_COLORS='rs=0:di=01;97;104:'

# ---------------------
# dotnet
# ---------------------
_dotnet_bash_complete()
{
  local word=${COMP_WORDS[COMP_CWORD]}

  local completions
  completions="$(dotnet complete --position "${COMP_POINT}" "${COMP_LINE}" 2>/dev/null)"
  if [ $? -ne 0 ]; then
    completions=""
  fi

  COMPREPLY=( $(compgen -W "$completions" -- "$word") )
}

complete -f -F _dotnet_bash_complete dotnet

# vim mode on bash
set -o vi
