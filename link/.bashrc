# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
HISTFILESIZE=2000
HISTSIZE=1000

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize

. ~/.bash_aliases
. ~/.bash_paths
. ~/.bash_prompt
. ~/bin/z/z.sh
