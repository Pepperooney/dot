# completion
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/home/uwe/.zshrc'
autoload -Uz compinit
compinit

# history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# options
setopt autocd extendedglob notify
bindkey -e

# add some colors
alias ls="ls --color"
autoload -U colors && colors

# gitstatus https://github.com/olivierverdier/zsh-git-prompt
source ~/.zsh/git-prompt/zshrc.sh

PROMPT='%{$fg_bold[green]%}%n%{$reset_color%}@%{$fg_bold[cyan]%}%m %{$fg_bold[yellow]%}%~%{$reset_color%}$(git_super_status) %# '
RPROMPT='[%{$fg_no_bold[yellow]%}%?%{$reset_color%}]'
