# Buffer history to continue history expansion even when it fails
function _recover_line_or_else() {
  if [[ -z $BUFFER && $CONTEXT = start && $zsh_eval_context = shfunc
        && -n $ZLE_LINE_ABORTED
        && $ZLE_LINE_ABORTED != $history[$((HISTCMD-1))] ]]; then
    LBUFFER+=$ZLE_LINE_ABORTED
    unset ZLE_LINE_ABORTED
  else
    zle .$WIDGET
  fi
}
zle -N up-line-or-history _recover_line_or_else
function _zle_line_finish() {
  ZLE_LINE_ABORTED=$BUFFER
}
zle -N zle-line-finish _zle_line_finish
