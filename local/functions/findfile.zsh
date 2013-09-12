#!/usr/bin/env zsh

# There's a file somewhere beneath the current directory...
# You know it has "foo" somewhere in its name...
# It also had "bar" somewhere in its name...
# You don't remember if it was "Foo" or "foo"
# So...
#   $ findfile foo OR bar
#   find . -iname "*foo*" -o -iname "*bar*" -print
#
# An 'AND' boolean is implied for two consecutive words:
#   $ findfile foo bar
#   find . -iname "*foo*" -a -iname "*bar*" -print

findfile() {
  notbool=0
  fargs=()
  for opt in $@; do
    case "${opt}" in
      AND) fargs+=( '-a' ) ; notbool=0 ; continue ;;
      NOT) fargs+=( '!' )  ; notbool=0 ; continue ;;
      OR)  fargs+=( '-o' ) ; notbool=0 ; continue ;;
      *)   notbool=$((notbool+1)) 
           [ ${notbool} -gt 1 ] && fargs+=( '-a' )
           fargs+=( '-iname' "*${opt}*" )
           ;;
    esac
  done
  printf '%s\n' "find . ${fargs[@]} -print" >&2
  noglob find . ${fargs[@]} -print
}



