#
# ~/.bashrc
#
# This file is executed by bash(1) for non-login shells.
# See /usr/share/doc/bash/examples/startup-files (in the package bash-doc) for examples

# Check if running interactively
case $- in
    *i*) ;;
    *) return ;;
esac

# History settings
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend

# Check the window size after each command and update LINES and COLUMNS
shopt -s checkwinsize

# Enable "**" pattern matching in pathname expansion
shopt -s globstar

# Automatically prepend "cd" when entering just a path in the shell
shopt -s autocd

# autocorrects cd misspellings
shopt -s cdspell

shopt -s dotglob

shopt -s expand_aliases

# Set a fancy prompt (non-color, unless color support is available)
case "$TERM" in
    xterm-color | *-256color) color_prompt=yes ;;
esac

# Set color support for the prompt
force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# Define the prompt format
# PS1='[\u@\h \W]\$ '

# If not running interactively, don't do anything
#[[ $- != *i* ]] && return

# Exported environment variables
export LD_PRELOAD=""
export EDITOR="nvim"
export GIT_PS1_SHOWDIRTYSTATE=1
export PATH="/home/abi/.local/bin:$PATH"
export PATH="/home/abi/.cargo/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export PATH=$PATH:~/.local/share/nvim/mason/bin
export XDG_CACHE_HOME="$HOME/.cache"
export PATH="${HOME}/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:"
export PATH="${PATH}/usr/local/sbin:/opt/bin:/usr/bin/core_perl:/usr/games/bin:"

# Source external scripts
source /usr/share/bash-completion/bash_completion
source /usr/share/bash-completion/completions/*
source /usr/share/git/completion/git-prompt.sh
source /usr/share/git/git-prompt.sh

# Prompt preview:
# [user@hostname]-[~]
# >>>
# Custom shell prompt
export PS1='\[\033[0;34m\]\[\033[1m\][\[\033[0m\]\[\033[0;36m\]\u\[\033[0;90m\]\[\033[1m\]\[\033[0;90m\]@\[\033[0m\]\[\033[0;36m\]\h\[\033[0;34m\]\[\033[1m\]]-\[\033[0m\]\[\033[0;34m\]\[\033[1m\][\[\033[0m\]\[\033[1;37m\]\w$(__git_ps1 " (%s)")\[\033[0;34m\]\[\033[1m\]\[\033[0m\]\[\033[0;34m\]\[\033[1m\]]\[\033[0m\]\n\[\033[0;34m\]\[\033[1m\]>>>\[\033[0m\]\[\033[0m\] '

# Colours have names too. Stolen from Arch wiki
Nblack="\[\033[0;30m\]"
NRed="\[\033[0;31m\]"
NGreen="\[\033[0;32m\]"
NYellow="\[\033[0;33m\]"
NBlue="\[\033[0;34m\]"
NPurple="\[\033[0;35m\]"
NCyan="\[\033[0;36m\]"
NWhite="\[\033[0;37m\]"

BBlack="\[\033[1;30m\]"
BRed="\[\033[1;31m\]"
BGreen="\[\033[1;32m\]"
BYellow="\[\033[1;33m\]"
BBlue="\[\033[1;34m\]"
BPurple="\[\033[1;35m\]"
BCyan="\[\033[1;36m\]"
BWhite="\[\033[1;37m\]"

LBlack="\[\033[0;90m\]"
LRed="\[\033[0;91m\]"
LGreen="\[\033[0;92m\]"
LYellow="\[\033[0;93m\]"
LBlue="\[\033[0;94m\]"
LPurple="\[\033[0;95m\]"
LCyan="\[\033[0;96m\]"
LWhite="\[\033[0;97m\]"

BLBlack="\[\033[1;90m\]"
BLRed="\[\033[1;91m\]"
BLGreen="\[\033[1;92m\]"
BLYellow="\[\033[1;93m\]"
BLBlue="\[\033[1;94m\]"
BLPurple="\[\033[1;95m\]"
BLCyan="\[\033[1;96m\]"
BLWhite="\[\033[1;97m\]"

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions

    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
fi

# Function to extract various types of archives
ex() {
	if [ -f $1 ]; then
		case $1 in
		*.tar.bz2) tar xjf $1 ;;
		*.tar.gz) tar xzf $1 ;;
		*.bz2) bunzip2 $1 ;;
		*.rar) unrar x $1 ;;
		*.gz) gunzip $1 ;;
		*.tar) tar xf $1 ;;
		*.tbz2) tar xjf $1 ;;
		*.tgz) tar xzf $1 ;;
		*.zip) unzip $1 ;;
		*.Z) uncompress $1 ;;
		*.7z) 7z x $1 ;;
		*.deb) ar x $1 ;;
		*.tar.xz) tar xf $1 ;;
		*.tar.zst) tar xf $1 ;;
		*) echo "'$1' cannot be extracted via ex()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

# Source custom aliases
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# Open files modified in a git commit in vim tabs; defaults to HEAD. Pop it in your .bashrc
# Examples:
#     virev 49808d5
#     virev HEAD~3
function virev {
    commit=$1
    if [ -z "${commit}" ]; then
      commit="HEAD"
    fi
    rootdir=$(git rev-parse --show-toplevel)
    sourceFiles=$(git show --name-only --pretty="format:" ${commit} | grep -v '^$')
    toOpen=""
    for file in ${sourceFiles}; do
      file="${rootdir}/${file}"
      if [ -e "${file}" ]; then
        toOpen="${toOpen} ${file}"
      fi
    done
    if [ -z "${toOpen}" ]; then
      echo "No files were modified in ${commit}"
      return 1
    fi
    vim -p ${toOpen}
}

# 'Safe' version of __git_ps1 to avoid errors on systems that don't have it
function gitPrompt {
  command -v __git_ps1 > /dev/null && __git_ps1 " (%s)"
}

# Source Autojump
if [ -f "/usr/share/autojump/autojump.sh" ]; then
	. /usr/share/autojump/autojump.sh
elif [ -f "/usr/share/autojump/autojump.bash" ]; then
	. /usr/share/autojump/autojump.bash
else
	echo "can't found the autojump script"
fi

# Enable bash programmable completion features in interactive shells
if [[ $PS1 && -f /usr/share/bash-completion/bash_completion ]]; then
	. /usr/share/bash-completion/bash_completion
elif [[ $PS1 && -f /etc/bash_completion ]]; then
	. /etc/bash_completion
elif [[ $PS1 && -f /usr/share/bash-completions/completions ]]; then
	. /usr/share/bash-completions/completions/*
fi

export PROMPT_COMMAND='source ~/.bashrc no-repeat-flag'

buffer_clean(){
  free -h && sudo sh -c 'echo 1 >  /proc/sys/vm/drop_caches' && free -h
}

# reporting tools - install when not installed and uncomment your favourite
if [[ $1 != no-repeat-flag ]]; then
  neofetch
fi

[[ $1 != no-repeat-flag && -f /usr/share/blesh/ble.sh ]] && source /usr/share/blesh/ble.sh

