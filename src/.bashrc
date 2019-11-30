set -o vi

bind -m vi-insert "\C-l":clear-screen

export LS_OPTIONS='--color=auto'

# Directory colours
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'

# Prompt prefix
export PS1='\[\e[1;35m\]\u \W\$ \[\e[m\]'

# Alias
if [ -f ~/.aliases ]; then
    source ~/.aliases
fi
