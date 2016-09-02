#http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html

# VARS

# vim / neovim
EDITOR=vim
VISUAL=vim
export TERM='xterm-256color'

export NODE_ENV=development


autoload -U colors compinit promptinit
colors
compinit
promptinit

# git branch, files to commit…
. ~/code/github/zsh/zsh-git-prompt/zshrc.sh
PROMPT='%{$fg_bold[red]%}%T %{$fg_no_bold[cyan]%}%j %{$fg[red]%}%! %{$fg[green]%}%n%{$reset_color%}@%{$fg[blue]%}%m%{$reset_color%}:%{$fg[yellow]%}%~%{$reset_color%}$(git_super_status)
%{$fg_bold[white]%}λ %{$reset_color%}'

# vim mode http://dougblack.io/words/zsh-vi-mode.html
# bindkey -v
# faster switch between mode
# export KEYTIMEOUT=1
# zle (zsh line editing) widgets

# function zle-line-init zle-keymap-select {
#   RPS1="${${KEYMAP/vicmd/N}/(main|viins)/}"
#   zle reset-prompt
# }
# zle -N zle-line-init
# zle -N zle-keymap-select

# CTRL+Z instead of typying fg explicitely https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    # execute above command
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z


. ~/.aliases
. ~/.paths
# shortcut jump
. ~/bin/z/z.sh
. ~/bin/humanism.sh/humanism.sh c
fpath=($HOME/.z/completions $fpath)

setopt auto_cd
setopt hist_ignore_dups

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Base16 Shell
BASE16_SHELL="$HOME/code/github/base16/base16-shell/base16-solarized.light.sh"
# BASE16_SHELL="$HOME/code/github/base16/base16-shell/base16-solarized.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
