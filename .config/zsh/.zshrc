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
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/histfile"
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
		(cat|less|echo|cd) return 1;;
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

# Autocompletion
# completion files for zsh to look for
fpath=(~/.local/share/zsh/site-functions/ $fpath)
# enable zsh completion
autoload -Uz compinit
compinit -u -d "$XDG_CACHE_HOME"/zsh/zcompdump-$ZSH_VERSION
# For autocompletion with arrow driven interface
# press Tab twice, to activate menu
zstyle ':completion:*' menu select
# For <sudo> autocompletions
zstyle ':completion::complete:*' gain-privileges 1
# Completion history with XDG dirs
[ -d "$XDG_CACHE_HOME"/zsh ] || /usr/bin/mkdir -p "$XDG_CACHE_HOME"/zsh
# autocompletion with arrows
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache
# include hidden files
_comp_options+=(globdots)

# Keybindings
# zsh doesn't use readline, but Zsh Line Editor (ZLE)
# keybindings are assigned by mapping a keysequence escape sequence, from terminfo, to a ZLE widget, listed in zshzle manual page.
# (source: https://wiki.archlinux.org/title/Zsh#Key_bindings)
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key
#
key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
#
# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete
#
# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
    autoload -Uz add-zle-hook-widget
    function zle_application_mode_start { echoti smkx }
    function zle_application_mode_stop { echoti rmkx }
    add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
    add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# History search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"  ]] && bindkey -- "${key[Up]}"  up-line-or-beginning-search
[[ -n "${key[Down]}"  ]] && bindkey -- "${key[Down]}"  down-line-or-beginning-search

# Change cursor like vim (source: https://github.com/LukeSmithxyz/voidrice/blob/master/.config/zsh/.zshrc)
function zle-keymap-select() {
	case $KEYMAP in
		vicmd) /usr/bin/echo -ne "\e[1 q" ;; # block
		viins|main) /usr/bin/echo -ne "\e[5 q";; # beam
	esac
}
zle -N zle-keymap-select
zle-line-init() {
	zle -K viins # initiate `vi insert` as keymap
	/usr/bin/echo -ne "\e[5 q"
}
zle -N zle-line-init
/usr/bin/echo -ne "\e[5 q" # use beam cursor on startup
preexec() { /usr/bin/echo -ne "\e[5 q" ;} # use beam cursor on each new prompt

# edit line in $EDITOR with ctrl-e:
autoload edit-command-line
zle -N edit-command-line

bindkey '^e' edit-command-line

# Clear backbuffer when clearing
# (source: https://wiki.archlinux.org/title/Zsh#Clear_the_backbuffer_using_a_key_binding)
function clear-screen-and-scrollback() {
    /usr/bin/echo -ne "\e[5 q"
    zle clear-screen
}

zle -N clear-screen-and-scrollback
bindkey '^L' clear-screen-and-scrollback

# automatically close parentheses and quotes
if [[ ! -d ~/.config/zsh/zsh-autopair/ ]]; then
	/usr/bin/git clone https://github.com/hlissner/zsh-autopair ~/.config/zsh/zsh-autopair
fi

source ~/.config/zsh/zsh-autopair/autopair.zsh
autopair-init

# fzf keybindings and completion
source <(/usr/bin/fzf --zsh)

# Syntax highlighting; should be last:
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
