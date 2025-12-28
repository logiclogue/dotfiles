# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

# Vi mode
set -o vi

bind -m vi-insert "\C-l":clear-screen

export LS_OPTIONS='--color=auto'

# Directory colours
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'

# Generate hostname colour based on hostname hash
_hostname_colour() {
    local hostname=$(hostname)
    local colours=(
        '31' # red
        '32' # green
        '33' # yellow
        '34' # blue
        '35' # magenta
        '36' # cyan
    )

    local hash=0
    for ((i=0; i<${#hostname}; i++)); do
        char="${hostname:$i:1}"
        hash=$((hash + $(printf '%d' "'$char")))
    done

    local colour_index=$((hash % ${#colours[@]}))
    local colour=${colours[$colour_index]}

    echo "\[\e[1;${colour}m\]${hostname}\[\e[m\]"
}

# Prompt prefix with hostname colour
export PS1="$(_hostname_colour) \W\$ "

# Fcitx5 input method
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

# Preferred editor for local and remote sessions
export EDITOR='nvim'
export PAGER='less'

# Pass password store directory
export PASSWORD_STORE_DIR=~/Documents/Secrets/pass

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Shell colours
export TERM=xterm-256color

# Alias
alias open="pcmanfm -d"
alias i3lock="i3lock -c \"#49483e\""

if [ -f ~/.aliases ]; then
    source ~/.aliases
fi
