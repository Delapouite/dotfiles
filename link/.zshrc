#http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html

# VARS

# vim / neovim
EDITOR=nvim
VISUAL=nvim
export NODE_ENV=development

autoload -U colors compinit promptinit
colors
compinit
promptinit

zstyle ':completion:*' menu select=10
zstyle ':completion:*' group-name ''

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

[ -f ~/.fzf.zsh ] && . ~/.fzf.zsh

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# BASE16_SHELL="$HOME/code/github/base16/base16-shell/scripts/base16-solarized-light.sh"
# BASE16_SHELL="$HOME/code/github/base16/base16-shell/scripts/base16-solarized-dark.sh"
# [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fmpc() {
  local song_position
  song_position=$(mpc -f "%position%) %artist% - %title%" playlist | \
    fzf-tmux --query="$1" --reverse --select-1 --exit-0 | \
    sed -n 's/^\([0-9]\+\)).*/\1/p') || return 1
  [ -n "$song_position" ] && mpc -q play $song_position
}
