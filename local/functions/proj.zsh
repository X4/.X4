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
