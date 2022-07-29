#
# .bash_aliases
#

# sudo
alias sudo="/usr/bin/doas"

# power
alias reboot="/usr/bin/doas /usr/bin/reboot"
alias poweroff="/usr/bin/doas /usr/bin/poweroff"

# pacman
alias syu="/usr/bin/doas /usr/bin/pacman -Syu"
alias pis="/usr/bin/doas /usr/bin/pacman -S"
alias rns="/usr/bin/doas /usr/bin/pacman -Rns"
alias pss="/usr/bin/pacman -Ss"
alias psi="/usr/bin/pacman -Si"
alias pqs="/usr/bin/pacman -Qs"
alias pqe="/usr/bin/pacman -Qe"
alias pqi="/usr/bin/pacman -Qi"
alias yss="/usr/bin/yay -Ss"
alias ysi="/usr/bin/yay -Si"
alias yqs="/usr/bin/yay -Qs"
alias yqe="/usr/bin/yay -Qe"
alias yqi="/usr/bin/yay -Qi"
alias yis="/usr/bin/yay -S"

# himalaya mail client
alias mail="/usr/bin/himalaya"
alias sent="/usr/bin/himalaya -m '[Gmail]/Sent Mail'"

# navigation
alias ..='cd ..' 
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

alias ls='/usr/bin/ls --color=auto'
alias grep='/usr/bin/grep --color=auto'

# confirm before overwriting something
alias cp="/usr/bin/cp -i"
alias mv="/usr/bin/mv -i"
alias rm="/usr/bin/rm -i"

# shortcuts
alias vi="/usr/bin/nvim"
alias vim="/usr/bin/nvim"
alias svim="/usr/bin/doas /usr/bin/nvim"
alias pp="/usr/bin/ping 8.8.8.8 -c 5"

# adding flags
alias df="/usr/bin/df -h"                          # human-readable sizes
alias free="/usr/bin/free -m"                      # show sizes in MB

# youtube-dl
alias yt="/usr/bin/yt-dlp --add-metadata -ic" # Download video links
alias yta="/usr/bin/yt-dlp --add-metadata -xic" # Download audio links
alias qq="/usr/bin/torsocks /usr/bin/yt-dlp --add-metadata -ic"

# wiki
alias wiki="/usr/bin/wiki-search" # search Arch-Wiki
alias wikk="/usr/bin/wikicurses" # search Wikipedia

# checkupdates
alias ccc="/usr/bin/checkupdates"

# Some bullshitting
alias bb="/usr/bin/bullshit"
