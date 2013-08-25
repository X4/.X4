#
# PAGER
#

zstyle -a ':zcontrol:module:environment:pager' pagers 'pager_list'

# If none were set, revert to some sane defaults...
if (( ${#pager_list[@]} == 0 )); then
  pager_list=( most less more )
fi

for cmd in ${pager_list[@]}; do
  if (( $+commands[${cmd}] )); then
    export PAGER="${cmd}"
    break
  fi
done

# Tidy up...
unset pager_list cmd