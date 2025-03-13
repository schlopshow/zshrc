#Schlop's Version zsh (Luke Smith's config as base)
# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments
source ~/.zprofile
# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
setopt inc_append_history

#Movement
alias htb="cd ~/Offsec/htb"
alias cata="cd ~/Projects/odin/catalyst"
alias labs="cd ~/Offsec/htb/labs"
alias vault="cd ~/Documents/general/vault"
alias bandit="cd ~/Offsec/wargames/bandit/"
alias pwn='cd ~/Offsec/ctf/pwn'
alias 0xl='cd ~/Offsec/ctf/0xlaugh'
alias acad='cd ~/Offsec/htb/academy/'
alias vms='cd ~/Downloads/vms/'
alias projects='cd ~/Projects'
alias thm='cd ~/Offsec/thm'
alias vpn='cd ~/Downloads/vpn/'
alias myprojects='cd ~/Projects/myprojects'
alias pico='cd ~/Offsec/pico'
alias la='~/Offsec/ctf/la/'

#Sourcing
alias sz="source ~/.zprofile"
alias szrc="source ~/.config/zsh/.zshrc"

#Editing Configs
alias ezsh="vim ~/.config/zsh/.zshrc"
alias ezp="vim ~/.zprofile"
alias edwm="sudo vim ~rr/dwm/config.h"
alias sdwm="cd ~rr/dwm && sudo make clean install"
alias ezrc="helix ~/.config/zsh/.zshrc"

#Commands
alias rmd="rm -r"
alias ls="ls -la"
alias vi='helix'
alias vim='helix'
alias or="odin run ."
alias hx="helix"
alias open='nemo'
alias svim="sudo helix"
alias sethost="sudo cp /etc/hosts.copy /etc/hosts"
alias update="sudo pacman -Syu --noconfirm --needed"
alias clone='git clone'
alias zshrc='~/.config/zsh'
alias yt='yt-dlp' 
alias passopen="~/.scripts/passopen.sh </dev/null &>/dev/null &"
alias rmr='rm -rf'
alias srm='sudo rm -rf'
alias ~="cd ~"
alias ..="cd .."
alias ...-"cd ..."

#UFW Aliases
alias ufwup='sudo ufw enable'
alias ufwdown='sudo ufw disable'
alias ufwrev='sudo ufw allow 8727 && sudo ufw allow out 8727'
alias ufwrevoff='sudo ufw deny 8727 && sudo ufw deny out 8727'
alias ufwstat='sudo ufw status numbered'
alias ufwreset='sudo ufw reset'

#Application Aliases
alias discord='flatpak run com.discordapp.Discord'
alias flameshot='flameshot gui'
alias resolve=' LD_PRELOAD="/usr/lib/libgio-2.0.so /usr/lib/libgmodule-2.0.so /usr/lib/libglib-2.0.so" /opt/resolve/bin/resolve'
alias kdenlive='./home/livid/Downloads/apps/kdenlive-24.12.2-x86_64.AppImage'

#Pentesting
alias boxmap='mkdir nmap && nmap -Pn -T5 -sC -sV -vv -oA nmap/$BOX $BOXIP'
alias portmap='mkdir portmap && nmap -p- -Pn -oA portmap/$BOX $BOXIP'
alias vp="sudo openvpn"

# Schlop's Functions
mka() {
    mkdir -p "$1" && echo "alias $1='cd $(realpath "$1")'" >> ~/.config/zsh/.zshrc && source ~/.config/zsh/.zshrc
}

mkcd() { mkdir -p "$1" && cd "$1"; }


BOXIP() {
    echo "export BOXIP=$1" > ~/.config/env/boxip_env
    export BOXIP="$1"
 }
boxip() {BOXIP "$@";}

 # This sources the environment files that get changed by the BOXIP function
[ -f ~/.config/env/boxip_env ] && source ~/.config/env/boxip_env

BOX() { echo "export BOX=$1" > ~/.config/env/box_env
    export BOX="$1"
}

box() {BOX "$@";}

 # This sources the environment files that get changed by the BOX function
[ -f ~/.config/env/box_env ] && source ~/.config/env/box_env





# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutenvrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutenvrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' '^ulfcd\n'

bindkey -s '^a' '^ubc -lq\n'

bindkey -s '^f' '^ucd "$(dirname "$(fzf)")"\n'

bindkey '^[[P' delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

# Load syntax highlighting; should be last.
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

# appended aliases created by mka()
# I should probably change this from taking the realpath to taking the variable $HOME
alias active='cd /home/livid/Offsec/htb/labs/active'
alias github='cd /home/livid/Projects/github'
alias progs='cd /home/livid/Projects/github/progs'
alias jarvis='cd /home/livid/Offsec/htb/labs/jarvis'
alias relevant='cd /home/livid/Offsec/thm/relevant'
alias codify='cd /home/livid/Offsec/htb/labs/codify'
alias flashcard='cd /home/livid/Documents/flashcard'
alias tabby='cd /home/livid/Offsec/htb/labs/tabby'
alias Cmess='cd /home/livid/Offsec/thm/Cmess'
alias sniper='cd /home/livid/Offsec/htb/sniper'
alias poison='cd /home/livid/Offsec/htb/labs/poison'
alias tartarsauce='cd /home/livid/Offsec/htb/labs/tartarsauce'
alias usage='cd /home/livid/Offsec/htb/labs/usage'
