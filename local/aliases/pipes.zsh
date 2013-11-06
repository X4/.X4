if test "${SHELL##*/}" = zsh; then
  alias -g G='| grep'
  alias -g P="| $PAGER"
  alias -g T='| tee /dev/tty |'
  alias -g F='| tail -f'
  alias -g N='/dev/null'
fi
