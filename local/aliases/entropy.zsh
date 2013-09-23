# Entropy / Portage
  alias e.q="equo match --multimatch --multirepo --installed"
  alias e.s="equo s "
  alias e.i="equo i --ask"
  alias e.rm="equo rm --ask"
  alias e.u="equo up && equo u --ask"
  alias e.up="equo up && eix-sync"
  alias e.status="while true ; do clear ; qlop -c ; sleep 2 ; done"
  alias e.log="tail -f /var/tmp/portage/*/${PKG}*/temp/build.log"
