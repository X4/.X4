##
## Consolidates your dotfiles into a single directory to keey your $HOME clutter-free
##
## Requires:
##   - The standard XDG Base Directories exist.
##   - The corresponding XDG variables are set.

## Extensions to the XDG Base Specification
typeset -gx XDG_LOCAL_DIR XDG_APP_HOME XDG_BIN_LINKS XDG_LIB_LINKS XDG_INCLUDE_LINKS

XDG_LOCAL_DIR="$HOME/.local"                # <------------------------------------.
XDG_APP_HOME="$XDG_LOCAL_DIR/app"           # -.                            .------'-------.
XDG_BIN_LINKS="$XDG_LOCAL_DIR/bin"          # -|__  Must all share a common parent directory
XDG_LIB_LINKS="$XDG_LOCAL_DIR/lib"          # -|    in order for symlinks to work properly.
XDG_INCLUDE_LINKS="$XDG_LOCAL_DIR/include"  # -'

## Ensure the extension directories exist 
if [ ! -d "$XDG_APP_HOME" -o ! -d "$XDG_BIN_LINKS" -o ! -d "$XDG_LIB_LINKS" -o ! -d "$XDG_INCLUDE_LINKS" ]; then
  mkdir -p "$XDG_APP_HOME" "$XDG_BIN_LINKS" "$XDG_LIB_LINKS" "$XDG_INCLUDE_LINKS"
fi


## Source the adapters...
for component in $(print ${0:h}/adaptors/*.zsh(.) /dev/null) ; do
  source "$component"
done