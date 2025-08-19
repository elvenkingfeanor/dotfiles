#!/bin/zsh
#
# ~/.zshenv
#

export ZDOTDIR="$HOME/.config/zsh/"

# import my common variables, if present
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/profile" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/profile"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/private" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/private"
