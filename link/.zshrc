EDITOR=vim
export NODE_ENV=development

autoload -U colors compinit promptinit
colors
compinit
promptinit

. ~/code/github/zsh/zsh-git-prompt/zshrc.sh
PROMPT='%{$fg_bold[red]%}%T %{$fg_no_bold[cyan]%}%j %{$fg[red]%}%! %{$fg[green]%}%n%{$reset_color%}@%{$fg[blue]%}%m%{$reset_color%}:%{$fg[yellow]%}%~%{$reset_color%}$(git_super_status)
%{$fg_bold[cyan]%}λ %{$reset_color%}'

# vim mode http://dougblack.io/words/zsh-vi-mode.html
# bindkey -v
# faster switch between mode
# export KEYTIMEOUT=1
# zle (zsh line editing) widgets

# function zle-line-init zle-keymap-select {
#     RPS1="${${KEYMAP/vicmd/N}/(main|viins)/}"
#     zle reset-prompt
# }
# zle -N zle-line-init
# zle -N zle-keymap-select

. ~/.aliases
. ~/.paths
# shortcut jump
. ~/bin/z/z.sh
. ~/bin/humanism.sh/humanism.sh c
