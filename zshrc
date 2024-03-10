test $UID -eq 0 && 
	CONFDIR="$XDG_CONFIG_DIRS" ||
	CONFDIR="$XDG_CONFIG_HOME" 

export ZSH="$CONFDIR/zsh"

ZSH_THEME="comical"

test -e $ZSH/oh-my-zsh.sh && source $ZSH/oh-my-zsh.sh

export HISTSIZE=2305843009213693951 #LONG_MAX / 4
export SAVEHIST=$HISTSIZE

prependpath () {
	IFS=":"
	case "$IFS$PATH$IFS" in
		*:"$1":*)
			;;
		*)
			PATH="$1$IFS${PATH:+$PATH}"
	esac
}

test -e $ZSH/opts && setopt $(
	 sed -En '/^[^#].*/{s/#.*//;p}' $ZSH/opts "$ZSH/opts" | tr '\n' ' '
)

test -e $ZSH/path && eval $(
	sed -nr 's/(^[^#].*)/prependpath "\1";/p' "$ZSH/path"
)

test -e $ZSH/alias && eval $(
	sed -e "s/'/'\"'\"'/g" -e '/^$/d' -e '/^#/d' "$ZSH/alias" |
	awk -F '\t' '{print "alias "$1"=""\047"$2"\047"}'
)
# less formatting variables: don't know why they seem to need to be set here
export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'	 # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'	 # begin bold
export LESS_TERMCAP_me=$'\E[0m'		# reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'		# reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'	 # begin underline
export LESS_TERMCAP_ue=$'\E[0m'		# reset underline

test -e $ZSH/funcs && source $ZSH/funcs

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [[ -z "$TMUX" ]]; then
  tmux
fi

HYPHEN_INSENSITIVE="true"
#KEYBOARD_HACK="]"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
#COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

