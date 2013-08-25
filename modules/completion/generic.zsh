#
# GNU Generic Completion
#
# Description:
#   The _gnu_generic completion definition attempts to auto-generate
#   completion for programs that accept the `--help` flag.
#
# Author:
#   J. Brandt Buckley <brandt@runlevel.com>
#
# These are used as a 'last resort' if hand-written completion isn't available.
#

case $OSTYPE in
  linux*)   # Linux Specific Commands
    # Utilities
    cmds+=( watch )        
    # Developer Tools
    cmds+=( ld )
  ;;
  darwin*)   # Mac OS X Specific Commands
    # Spotlight
    cmds+=( mdfind mdls mdutil mdimport mddiagnose )
    # Developer Tools
    cmds+=( dtrace pkgutil dtrace otool )
    # Utilities
    cmds+=( ioreg )
  ;;
esac

# OS Agnostic

# Compression
cmds+=( gzip gzcat gzexe gunzip tar gnutar zcat znew )

# Developer Tools
cmds+=( autoconf aclocal autoheader automake autom4te autoreconf m4 gm4 )
cmds+=( gcc cc cpp bison yacc lex flex make gnumake )
cmds+=( etags ctags gcov )

# Interpreters and Shells
cmds+=( bash ksh awk gawk gsed )

# Fileutils
cmds+=( cmp diff diff3 patch grep egrep fgrep sort file )

# Editors
cmds+=( nano mate emacs )

# Checksum
cmds+=( sha1sum shasum )

# Text Tools
cmds+=( groff iconv info install-info makeinfo texi2html )
  
# Utilities
cmds+=( pv )

# Autogenerate completion for the commands listed above.
gnu_generic ${cmds[@]}

unset cmds