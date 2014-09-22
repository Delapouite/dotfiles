# keyboards
alias fr='setxkbmap fr'
alias us='setxkbmap us'
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

function server() {
    local port="${1:-8000}"
    xdg-open "http://localhost:${port}/" &
    python -m SimpleHTTPServer "$port"
}
