# X.org

alias startx='ssh-agent startx'

# keyboards

alias fr='kbswitch.sh fr'
alias us='kbswitch.sh us'
alias qwfr='kbswitch.sh us_qwerty-fr'
alias bepo='kbswitch.sh fr bepo'
alias notouchpad='xinput --set-prop 14 "Device Enabled" 0'

# enable color support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# ls

alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias lsd='ll --group-directories-first'
function lc () {
    cd "$@" && ls
}


# tar

alias mktar='tar -cvzf'
alias extar='tar -xvzf'

alias adios='systemctl poweroff'
alias cal='cal --monday'
alias open='xdg-open'
alias zik='ncmpcpp'

# network

alias lservers='netstat -lnpt'
function server() {
    local port="${1:-8000}"
    xdg-open "http://localhost:${port}/" &
    python -m http.server "$port"
}
