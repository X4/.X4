#
# LS
#

if (( $+commands['dircolors'] )); then
  # GNU Core Utilities
  if zstyle -t ':zcontrol:module:environment:ls' color; then
    if [[ -s "${XDG_CONFIG_HOME}/ls/dir_colors" ]]; then
      ## First check XDG path for dircolors.
      eval "$(dircolors "${XDG_CONFIG_HOME}/ls/dir_colors")"
    elif [[ -s "${HOME}/.dir_colors" ]]; then
      ## Then check $HOME for dircolors
      eval "$(dircolors "${HOME}/.dir_colors")"
    else
      ## Then just execute dircolors
      eval "$(dircolors)"
    fi
  fi
else
  # BSD Core Utilities
  if zstyle -t ':zcontrol:module:environment:ls' color; then
    ## Define colors for BSD ls.
    export LSCOLORS='exfxcxdxbxGxDxabagacad'
    
    ## Define colors for the completion system.
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'
  fi
fi
