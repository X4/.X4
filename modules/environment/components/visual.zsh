#
# VISUAL & EDITOR
#
# Note: $EDITOR is a legacy variable from the days of teletypes.
#       In modern terminals, it should be set to the same value as $VISUAL.

zstyle -a ':zcontrol:module:environment:visual' editors 'editor_list'

# If none were set, revert to some sane defaults...
if (( ${#editor_list[@]} == 0 )); then
  editor_list=(vim vi nano pico)
fi

for cmd in ${editor_list[@]}; do
  if (( $+commands[$cmd] )); then
    export VISUAL="${cmd}"
    export EDITOR="${cmd}"
    break
  fi
done

# Tidy up...
unset editor_list cmd