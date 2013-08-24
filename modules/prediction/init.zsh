# command prediction from history

autoload -U predict-on
zle-line-init() { predict-on }
zle -N zle-line-init
zle -N predict-on
zle -N predict-off
zstyle ':predict' verbose false

#autoload -U predict-on
#zle -N predict-on
#zle -N predict-off
#bindkey '^o^p' predict-on
#bindkey '^op' predict-off
#bindkey '^n' predict-on
#bindkey '^o^p' predict-off
#zstyle ':predict' toggle true
#zstyle ':predict' verbose true
 
