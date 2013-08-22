# Entropy / Portage
  alias e.q="equo match --multimatch --multirepo --installed"
  alias e.search="equo s "
  alias e.install="equo i --ask"
  alias e.rm="equo rm --ask"
  alias e.up="equo up && equo u --ask"
  alias e.sync="equo up ; layman -S ; eix-sync"
  alias e.status="while true ; do clear ; qlop -c ; sleep 2 ; done"
  alias e.log="tail -f /var/tmp/portage/*/${PKG}*/temp/build.log"
 
