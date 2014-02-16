## Case insensitive search for files and directories, partial matches allowed
## - Usage: f <name>
function f() {
   find . -iname "*$1*"
}


# interactive mv
function mv.i() {
  local src dst
  for src; do
    [[ -e $src ]] || { print -u2 "$src does not exist"; continue }
    dst=$src
    vared dst
    [[ $src != $dst ]] && mkdir -p $dst:h && mv -n $src $dst
  done
}


# Show symbolic links
function l.symbolic() {
  stat --terse -c "%a %s %n" ${1:-$(pwd)}/*(ND@) 2>|/dev/null || echo "No symlinks here, go on."
}


# Show empty dirs
function l.emptydirs() {
  declare -r EOL=$'\n' TAB=$'\t'
  if [[ $(find ${1:-$(pwd)} -maxdepth 1 -type d -empty) = *$EOL* ]]; then
    find ${1:-$(pwd)} -maxdepth 1 -type d -empty
  else
    echo "No empty directories here, you lucky."
  fi
}


## Diff two XML documents
## - diffxml doc1.xml doc2.xml
function diffxml() {
   diff -wb <(xmllint --format "$1") <(xmllint --format "$2");
}


## Jump to Source directory and list the top 10 most recent directories
## - Usage: proj [c|i|e|p|l]
function proj() {
  local goto_dir="$1"
  cd ${HOME}/Projects
  if [ -z "${goto_dir}" ]; then
    CLICOLOR_FORCE=1 ls -G -dtrnl */*(/om[1,10]) | tr -s ' ' | cut -d' ' -f6-
    printf '%s' "Personal, Evaluating, CRBS, IGPP, or Last modified: (c,i,e,p,l): "
    read -k 1 goto_dir
    echo
  fi
  case ${goto_dir} in
    c) cd CRBS ;;
    i) cd IGPP ;;
    e) cd Evaluating ;;
    p) cd Personal ;;
    l) cd */*(/om[1]) ;;
  esac
  printf '\033[38;1m%s\033[0m\n' "$(pwd)"
  if [ $(ls -1 | wc -l) != 0 ]; then
    CLICOLOR_FORCE=1 ls -dtrnl *(/om[1,10])
  fi
}

function timewarp() {
  for i in $1; do
    touch -m -d "$(stat -c %y "$i") $2" "$i"
  done
}