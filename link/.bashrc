# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth:erasedups
HISTFILESIZE=2000
HISTSIZE=1000
HISTIGNORE="bg:cd:clear:exit:fg:l:ll:ls:pwd:startx:sudo shutdown now:sudo wifi-menu:vim ."

export NODE_ENV=development

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize

. ~/.bash_aliases
. ~/.bash_paths
. ~/.bash_prompt
. ~/bin/z/z.sh
if [ -f ~/.git-completion.bash ]; then
	. ~/.git-completion.bash
fi
