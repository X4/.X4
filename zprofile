#########################################
# Executes commands at login, pre-zshrc.
#########################################
# support colors in ls
[ -f /etc/DIR_COLORS ] && eval $(dircolors -b /etc/DIR_COLORS)
export ZLSCOLORS="${LS_COLORS}"

# support colors in less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# locale setup
xsource "/etc/default/locale"
if [[ -z "$LC_ALL" ]]; then
    export LC_ALL="$LANG"
fi

# set TZ to timezone
TZ=$(xcat /etc/timezone)

# set default shell to zsh
export SHELL='/bin/zsh'

# Browser
if [[ "$OSTYPE" = darwin* ]]; then
    export BROWSER='open'
fi

# Python
export PYTHONUSERBASE="$HOME/.local"

# PyEnv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"