# If not running interactively, don't do anything
case "$-" in
    *i*) ;; # interactive
    *) return ;;
esac

# utils
_have() { type "$1" &>/dev/null; }

# env
export LANG=en_US.UTF-8 
export USER="${USER:-$(whoami)}"
export GITUSER="$USER"
export TZ=America/New_York
export REPOS="$HOME/Repos"
export GH_REPOS="$HOME/Repos/github.com/antgray"
export EDITOR=vim
export SUDO_EDITOR=vim
export VISUAL=vim
export LC_COLLATE=C
export LESS="-RXF --use-color -Dd+b\$Du+g"

# XDG
export XDG_CACHE_HOME=~/.local/var/cache
export XDG_CONFIG_DIR=~/.local/etc
export XDG_DATA_HOME=~/.local/share
export XDG_STATE_HOME=~/.local/var/lib
export XDG_LIB_HOME=~/.local/lib
export XDG_LOG_HOME=~/.local/var/log

#Non standard XDG
export HISTFILE="$XDG_STATE_HOME"/bash/history
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

#cdpath
export CDPATH=".:$GH_REPOS:$REPOS:$HOME"
export PATH="$PATH":"$HOME"/.local/bin

# shell opts
shopt -s checkwinsize # enables $COLUMNS and $ROWS
shopt -s expand_aliases
shopt -s globstar
shopt -s dotglob
shopt -s extglob

# history
export HISTCONTROL=ignoreboth
export HISTSIZE=5000
export HISTFILESIZE=10000

set -o vi
shopt -s histappend

# prompt
export PS1='\e[1;34m\]\u@\h\e[00m\] : \e[1;32m\]\W\e[00m\]\n$ '

# pager
if [[ -x /usr/bin/lesspipe ]]; then
	export LESSOPEN="| /usr/bin/lesspipe %s"
	export LESSCLOSE="/usr/bin/lesspipe %s %s"
fi

# dircolors
if _have dircolors; then
	if [[ -r "$XDG_CONFIG_HOME/dircolors" ]]; then
		eval "$(dircolors -b "$XDG_CONFIG_HOME/dircolors")"
	else
		eval "$(dircolors -b)"
	fi
fi

# bash-aliases
if [ -f "$HOME/.bash_aliases" ]; then
		source "$HOME/.bash_aliases"
fi

eval "$(beet completion)"

_have ansible && . <(register-python-argcomplete ansible)
_have ansible-config && . <(register-python-argcomplete ansible-config)
_have ansible-console && . <(register-python-argcomplete ansible-console)
_have ansible-doc && . <(register-python-argcomplete ansible-doc)
_have ansible-galaxy && . <(register-python-argcomplete ansible-galaxy)
_have ansible-inventory && . <(register-python-argcomplete ansible-inventory)
_have ansible-playbook && . <(register-python-argcomplete ansible-playbook)
_have ansible-pull && . <(register-python-argcomplete ansible-pull)
_have ansible-vault && . <(register-python-argcomplete ansible-vault)

