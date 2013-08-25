#
# Sets key bindings.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   J. Brandt Buckley <brandt@runlevel1.com>
#
# Usage:
#   To enable key bindings, add the following to zcontrol, and replace 'map'
#   with 'emacs' or 'vi.
#
#     zstyle ':zcontrol:module:editor' keymap 'map'
#
#   To enable the auto conversion of .... to ../.., add the following to
#   zcontrol.
#
#     zstyle ':zcontrol:module:editor' dot-expansion 'yes'
#
#   To indicate when the editor is in the primary keymap (emacs or viins), add
#   the following to your theme prompt setup function.
#
#     zstyle ':zcontrol:module:editor:info:keymap:primary' format '>>>'
#
#   To indicate when the editor is in the primary keymap (emacs or viins) insert
#   mode, add the following to your theme prompt setup function.
#
#     zstyle ':zcontrol:module:editor:info:keymap:primary:insert' format 'I'
#
#   To indicate when the editor is in the primary keymap (emacs or viins)
#   overwrite mode, add the following to your theme prompt setup function.
#
#     zstyle ':zcontrol:module:editor:info:keymap:primary:overwrite' format 'O'
#
#   To indicate when the editor is in the alternate keymap (vicmd), add the
#   following to your theme prompt setup function.
#
#     zstyle ':zcontrol:module:editor:info:keymap:alternate' format '<<<'
#
#   To indicate when the editor is completing, add the following to your theme
#   prompt setup function.
#
#     zstyle ':zcontrol:module:editor:info:completing' format '...'
#

# Return if requirements are not found.
if [[ "$TERM" == 'dumb' ]]; then
  return 1
fi

#
# Options
#

# Beep on error in line editor.
setopt BEEP

# Allow command line editing in an external editor.
autoload -Uz edit-command-line
zle -N edit-command-line

#
# Variables
#

# Use human-friendly identifiers.
# See: man 5 terminfo
# To list widgets: zle -la
zmodload zsh/terminfo
typeset -gA key_info
key_info=(
  'Control'    '\C-'
  'Escape'     '\e'
  'Meta'       '\M-'
  'Backspace'  "^?"
  'Delete'     "^[[3~"
  'F1'         "$terminfo[kf1]"
  'F2'         "$terminfo[kf2]"
  'F3'         "$terminfo[kf3]"
  'F4'         "$terminfo[kf4]"
  'F5'         "$terminfo[kf5]"
  'F6'         "$terminfo[kf6]"
  'F7'         "$terminfo[kf7]"
  'F8'         "$terminfo[kf8]"
  'F9'         "$terminfo[kf9]"
  'F10'        "$terminfo[kf10]"
  'F11'        "$terminfo[kf11]"
  'F12'        "$terminfo[kf12]"
  'Insert'     "$terminfo[kich1]"
  'Home'       "$terminfo[khome]"
  'End'        "$terminfo[kend]"
  'BackTab'    "$terminfo[kcbt]"
  'ShiftLeft'  "$terminfo[kLFT]"
  'ShiftRight' "$terminfo[kRIT]"
  'ShiftUp'    "$terminfo[kind]"
  'ShiftDown'  "$terminfo[kri]"
  'Left'       "$terminfo[kcub1]"
  'Right'      "$terminfo[kcuf1]"
  'Up'         "$terminfo[kcuu1]"
  'Down'       "$terminfo[kcud1]"
  'PageDown'   "$terminfo[knp]"
  'PageUp'     "$terminfo[kpp]"
# 'ShiftUp'    '^[[1;2A'  # kind ?
# 'ShiftDown'  '^[[1;2B'  # kri ?
)

# Set empty $key_info values to an invalid UTF-8 sequence to induce silent
# bindkey failure.
for key in "${(k)key_info[@]}"; do
  if [[ -z "$key_info[$key]" ]]; then
    key_info["$key"]='�'
  fi
done


#
# Component widgets
#
# Note: These widgets are created based on corresponding functions.

zle -N editor-info
zle -N zle-keymap-select
zle -N zle-line-finish
zle -N zle-line-init
zle -N prepend-sudo
zle -N overwrite-mode
zle -N insert-datestamp
zle -N expand-or-complete-with-indicator
zle -N expand-dot-to-parent-directory-path
zle -N prepend-sudo
zle -N vi-replace
zle -N vi-insert
zle -N vi-insert-bol


# Reset to default key bindings.
bindkey -d

# Source the keybindings that apply to boty *emacs* and *vi insert mode*:
for keymap in 'emacs' 'viins' ; do
  # $keymap defines to which keymap each line of the "both" file is applied.
  . ${0:h}/keymaps/common
done

# Source the statically-defined keymaps
for keymap in 'emacs' 'viins' 'vicmd' 'isearch' ; do
  . ${0:h}/keymaps/${keymap}
done


#
# Layout
#

# Set the key layout.
zstyle -s ':zcontrol:module:editor' keymap 'keymap'
if [[ "$keymap" == (emacs|) ]]; then
  # Set to emacs if "emacs" or nothing.
  bindkey -e
elif [[ "$keymap" == vi ]]; then
  # Set to vi if explicitly set.
  bindkey -v
else
  print "zcontrol: invalid keymap: $keymap" >&2
fi

unset key{map,}
