#
# spotlight - items related to the Mac OS X Spotlight search system
#

if ! [[ $OSTYPE =~ ^darwin* ]]; then
  return 1
fi

# mdlocate
#
# mdfind performs a Spotlight search, returning both files with
# matches in their filenames and/or their content.
#
# This alias invokes mdfind with a flag that limits the search
# to the filename, making it behave like ``locate'' (mlocate).
alias mdlocate='mdfind -name'