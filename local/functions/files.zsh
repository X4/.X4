## Case insensitive search for files and directories, partial matches allowed
## - Usage: f <name>
function f() { find . -iname "*$1*" }

# interactive mv
imv() {
  local src dst
  for src; do
    [[ -e $src ]] || { print -u2 "$src does not exist"; continue }
    dst=$src
    vared dst
    [[ $src != $dst ]] && mkdir -p $dst:h && mv -n $src $dst
  done
}
