EDITOR=vim
export NODE_ENV=development

autoload -U colors compinit promptinit
colors
compinit
promptinit

. ~/code/github/zsh/zsh-git-prompt/zshrc.sh
PROMPT='%{$fg_bold[red]%}%T %{$fg_no_bold[cyan]%}%j %{$fg[red]%}%! %{$fg[green]%}%n%{$reset_color%}@%{$fg[blue]%}%m%{$reset_color%}:%{$fg[yellow]%}%~%{$reset_color%}$(git_super_status)
%{$fg_bold[cyan]%}λ %{$fg_bold[white]%}'

# reset color after prompt
preexec () { echo -ne "\e[0m" }

. ~/.aliases
. ~/.paths
# shortcut jump
. ~/bin/z/z.sh
