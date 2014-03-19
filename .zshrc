# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/home/uwe/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob notify
bindkey -e
# End of lines configured by zsh-newuser-install

alias ls="ls --color"

autoload -U colors && colors
PROMPT="%{$fg_bold[green]%}%n%{$reset_color%}@%{$fg_bold[cyan]%}%m %{$fg_bold[yellow]%}%~ %{$reset_color%}%# "
RPROMPT="[%{$fg_no_bold[yellow]%}%?%{$reset_color%}]"
