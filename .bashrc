#
# .bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ $DISPLAY ]] && shopt -s checkwinsize

PS1='[\u@\h \W]\$ '

source $HOME/.bash_profile
source $HOME/.bash_aliases
source $HOME/.bash_logout
source $HOME/.bash_private
source /usr/share/doc/pkgfile/command-not-found.bash
