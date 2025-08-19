#!/bin/zsh
#
# ~/.config/zsh/.zshrc
#

# Prompts
autoload -Uz promptinit
promptinit
#prompt redhat
PS1='[%n %1~]$%  '

# source my aliases, if present
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/profile" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/profile"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/private" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/private"

# History
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE
setopt hist_ignore_dups # ignore duplicated previous command
setopt hist_ignore_all_dups # ignore duplicates in history
setopt hist_save_no_dups # omit older duplicates in history
setopt hist_ignore_space # ignore events starting with a space
setopt inc_append_history # append to history file immediately
setopt hist_no_store # ignore history command from history
setopt share_history # terminals share history
# ignore these commands in history
zshaddhistory() {
	case "${1%% *}" in
		(man|cat|less|echo|nvim|vi|pss|psi|yss|ysi|cl|cll|cdd|cd|clc|clear|tree|clt|gss|gpp|fcc|df|du|brtt|batt|mute|vol|mic|mic-test|iv|pp|mm|mmm|torr|wttr|cu|cn|yt|yta|zathura|zz) return 1;;
	esac
	return 0;
}

# misc
setopt notify
unsetopt beep # disable beep
bindkey -v # enable vi mode
export KEYTIMEOUT=1
setopt interactive_comments
# tell compinstall where zstyle statements are installed
zstyle :compinstall filename '~/.config/zsh/.zshrc'

# enable zsh completion
autoload -Uz compinit
compinit
_comp_options+=(globdots) # include hidden files
# For autocompletion with arrow driven interface
# press Tab twice, to activate menu
zstyle ':completion:*' menu select
# For <sudo> autocompletions
zstyle ':completion::complete:*' gain-privileges 1

# History search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"  ]] && bindkey -- "${key[Up]}"  up-line-or-beginning-search
[[ -n "${key[Down]}"  ]] && bindkey -- "${key[Down]}"  down-line-or-beginning-search

# edit line in vim with ctrl-e:
autoload edit-command-line
zle -N edit-command-line

bindkey '^e' edit-command-line

# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
