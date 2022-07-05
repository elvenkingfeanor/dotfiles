#
# ~/.bash_profile
#

# set tty console font
setfont ter-120b

# set key repeat rate
xset r rate 300 40

# turn off annoying beep
set bell-style none

# set vi mode
set -o vi

# autocd
shopt -s autocd

# prevent overwrite of files
set -o noclobber

# defaults
export PAGER=/usr/bin/less
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export READER=/usr/bin/zathura
export BROWSER=/usr/bin/lynx

# keep history file
set -o history

# clear history on exit
unset HISTFILE

# append to history
shopt -s histappend

# ignore these commands
export HISTIGNORE="pass:gpg:mail:himalaya:make:man:nnn:vim:nvim:vi:vvv:pacman:sudo:doas:pss:psi:pqs:pqi:rns:syu:yss:ysi:yqs:yqi:ccc:checkupdates:yt:yta:qq:pp:ping:clear:ls:cd:cp:mv:rm:cat:less:df:grep:sr:lynx"

# ignore duplicates
export HISTCONTROL="ignoredups:erasedups"

# nnn
export NNN_BMS="c:/home/ts/Documents;d:/home/ts/Downloads;m:/home/ts/misc;n:/home/ts/misc/novels;t:/home/ts/Downloads/torrents;v:/home/ts/Videos;V:/home/ts/Videos/series;w:/home/ts/misc/my_items_and_wishlist;z:/home/ts/misc/links_and_crossings/local_corridors"
export NNN_FIFO="/tmp/nnn.fifo"
export NNN_PLUG='f:fzplug;p:preview-tui'

# xdg-usr-directories
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_VIDEOS_DIR="$HOME/Videos"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_STATE="$HOME/.local/state"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="/etc/xdg"

# add custom folder to Path
#export PATH="${PATH}:/home/ts/.local/bin"

# lesshistfile
export LESSHISTFILE="$XDG_DATA_HOME/lesshst"

# define Home for Lynx
export WWW_HOME="https://duckduckgo.com"
