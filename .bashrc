# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# bash-completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
if [ -d /usr/local/etc/bash_completion.d ]; then
    for f in /usr/local/etc/bash_completion.d/*; do
        . $f
    done
fi

# PATH
export PATH="/usr/local/bin:/usr/local/sbin:$PATH:/opt/local/bin"

# locale settings
export LANG=en_US.UTF-8
export LANGUAGE=en_US
export LC_CTYPE=en_US.UTF-8
export LC_COLLATE=en_US.UTF-8
export LC_MONETARY=de_DE.UTF-8
export LC_NUMERIC=de_DE.UTF-8
export LC_TIME=de_DE.UTF-8
export LC_MESSAGES=en_US.UTF-8

# history
export HISTTIMEFORMAT='[%Y-%m-%d %T] '

# only if interactive shell
if [ -n "$PS1" ]; then
    # Prompt if interactive
    ## git-branch
    function gitbranch {
        gitbranch=$(git branch --no-color 2> /dev/null | sed -n 's/$/]/;s/\* /[/p')
    }
    PROMPT_COMMAND="gitbranch"
    ## now build the prompt
    PS1='\[\e]0;\u@\h${gitbranch}:\w\a\]\[\e[0;34m\]\u\[\e[0m\]@\[\e[0;32m\]\h\[\e[0;35m\]${gitbranch}\[\e[0m\]:\[\e[0;33m\]\w\[\e[0m\]\$'
fi

# aliases
alias nfo='iconv -f cp437 -t utf-8'
alias tmux='echo -ne "\033]0;$(hostname):tmux\007"; tmux'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias takeover="tmux detach -a"
alias axel="axel -an $[RANDOM%20+10]"
