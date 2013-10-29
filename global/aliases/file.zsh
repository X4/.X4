alias ls='ls --color=auto'
alias l='ls --color=auto --group-directories-first'
alias ll='ls --color=auto --time-style=long-iso --group-directories-first -FbLlh'
alias la='ls --color=auto --time-style=long-iso --group-directories-first -FAblh'
alias lt='ls --color=auto --time-style=long-iso -FAbltrh'
alias mv='mv -i'
alias rm='rm -i'
alias RM='rm -vrf'
alias to.Array="xxd -i"
alias df='df -h'

duh() { # disk usage for humans
  test $# -eq 0 && set -- *
  du -sch "$@" | sort -h
}

if [ ! -x "$(which tree 2>/dev/null)" ]; then
  alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
else
  alias tree='tree -ACF'
fi

backup.move() { # backup with move
  for file; do
    mv -v $file{,.bak}
  done
}

backup.move.undo() { # undo backup move
  for file; do
    mv -v "$file" "${file%.bak}"
  done
}

backup.copy() { # backup with copy
  for file; do
    cp -Rpv "$file" "$file~$(date -Ins)~"
  done
}

backup.copy.undo() { # undo backup copy
  for file; do
    dest=${file%%\~*}
    test -d "$dest" && mv -v "$dest" "$file.orig"
    mv -v "$file" "$dest"
  done
}

mount.dir.ro() {
  sudo mount --bind "$@" &&
  sudo mount -o remount,ro,bind "$@"
}
