# completion
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/home/uwe/.zshrc'
autoload -Uz compinit
compinit

# history
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=2000
# history searching by up/down key, thanks to https://github.com/graysky2/configs/tree/master/dotfiles
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '\eOA' up-line-or-beginning-search
bindkey '\e[A' up-line-or-beginning-search
bindkey '\eOB' down-line-or-beginning-search
bindkey '\e[B' down-line-or-beginning-search

setopt APPEND_HISTORY HIST_EXPIRE_DUPS_FIRST EXTENDED_HISTORY

# options
setopt autocd extendedglob notify BRACE_CCL
bindkey -e

# add some colors
if [ "$(uname)" != "Darwin" ]; then
    alias ls='ls --group-directories-first --color'
fi
alias grep='grep --color=auto'
alias zgrep='zgrep --color=auto'
autoload -U colors && colors

# gitstatus https://github.com/olivierverdier/zsh-git-prompt
source ~/.zsh/git-prompt/zshrc.sh

PROMPT='%{$fg_bold[green]%}%n%{$reset_color%}@%{$fg_bold[cyan]%}%m %{$fg_bold[yellow]%}%~%{$reset_color%} %# '
RPROMPT='$(git_super_status)[%{$fg_no_bold[yellow]%}%?%{$reset_color%}]'

# syntax highlighting
source ~/.zsh/syntax-highlighting/zsh-syntax-highlighting.zsh

# work
[ -f ~/.zshrc.work ] && source ~/.zshrc.work

# aliases
source ~/dot/bin/pkgrep.zsh
alias takeover="tmux detach -a"
