# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(autojump cp dircycle git git-extras gitfast history pip rsync urltools)
#plugins=(autojump ruby compleat cp dircycle git git-extras gitfast history history-substring-search kate laravel node npm pass pip python rails3 rake rbenv rbfu redis-cli rsync screen sprunge themes urltools vagrant)

source $ZSH/oh-my-zsh.sh

export LESS="-erX"
export CLICOLOR=true
#export LSCOLORS=Exfxcxdxbxegedabagacad

# Shell history settings
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

export HISTTIMEFORMAT='%F %T '
export HISTCONTROL=erasedups
export HISTIGNORE="&:l:ls:ll:la:lsa:tyls:pwd:exit:clear:ps:psa" #Never log these

# How many lines of growth before rotating .zsh_history
ROTATEHIST=10000
# How many .zsh_history file rotations to keep
MAXHISTFILES=20

#########################################
# ZSH Theming
#########################################
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
if [[ -e $HOME/.zsh_custom ]]; then
        source $HOME/.zsh_custom
fi

#if [[ -e $HOME/.zsh_prompt ]]; then
#	source $HOME/.zsh_prompt
#fi

#########################################
# Shell Functions
#########################################
source $HOME/.X4/functions/aliases
source $HOME/.X4/functions/helpers
# source $HOME/.X4/functions/vga_switch

# ZSH Tuning
source $HOME/.X4/functions/zsh_compile

