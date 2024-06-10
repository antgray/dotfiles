# If not running interactively, don't do anything
case "$-" in
    *i*) ;; # interactive
    *) return ;;
esac

# utils
_have() { type "$1" &>/dev/null; }

# format: https://github.com/user/repo (no .git ext)
clone() {
	local repo="$1" user
	local repo="${repo#https://github.com/}"
	local repo="${repo#git@github.com:}"
	if [[ $repo =~ / ]]; then
		user="${repo%%/*}"
	else
		user="$GITUSER"
		[[ -z "$user" ]] && user="$USER"
	fi
	local name="${repo##*/}"
	local userd="$REPOS/github.com/$user"
	local path="$userd/$name"
	[[ -d "$path" ]] && cd "$path" && return
	mkdir -p "$userd"
	cd "$userd"
	echo gh repo clone "$user/$name" -- --recurse-submodule
	gh repo clone "$user/$name" -- --recurse-submodule
	cd "$name"
} && export -f clone

# env
set -o vi

export LANG=en_US.UTF-8 
export USER="${USER:-$(whoami)}"
export GITUSER="$USER"
export TZ=America/New_York
export REPOS="$HOME/Repos"
export GH_REPOS="$HOME/Repos/github.com/antgray"
export EDITOR=vim
export SUDO_EDITOR=vim
export SYSTEMD_EDITOR=vim
export VISUAL=vim
export LC_COLLATE=C
export LESS="-RXF --use-color -Dd+b\$Du+g"

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
export PROMPT_COMMAND="history -n;history -w;history -c;history -r;$PROMPT_COMMAND"
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

# eval "$(beet completion)"

_have ansible && . <(register-python-argcomplete ansible)
_have ansible-config && . <(register-python-argcomplete ansible-config)
_have ansible-console && . <(register-python-argcomplete ansible-console)
_have ansible-doc && . <(register-python-argcomplete ansible-doc)
_have ansible-galaxy && . <(register-python-argcomplete ansible-galaxy)
_have ansible-inventory && . <(register-python-argcomplete ansible-inventory)
_have ansible-playbook && . <(register-python-argcomplete ansible-playbook)
_have ansible-pull && . <(register-python-argcomplete ansible-pull)
_have ansible-vault && . <(register-python-argcomplete ansible-vault)

bind -f ~/.inputrc
