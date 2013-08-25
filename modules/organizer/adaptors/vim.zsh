#
# vim - alternate path to vimrc
#

export VIMINIT="source $(dotfile vim config print vimrc)"

# ~/.viminfo
## To change the location of the default ~/.viminfo
## Put this in your $XDG_CONFIG_HOME/vimrc file
##    set viminfo+=n$XDG_DATA_HOME/vim/viminfo
dotfile vim data file viminfo >/dev/null

# Note: See also $VIM
