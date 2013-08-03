# Enhancements
  alias gdb="gdb -q"
  alias bc="bc -q -l ~/.bcrc"
  alias cal="cal -m -3"
# Prettify mount output
  alias mount="mount | column -t"
# Show favorite commands
  alias favs="history | awk '{print $2}' | sort | uniq -c | sort -rn | head"
  alias stay="tail -f"
# Reload config and reset terminal
  alias cls=". ~/.config/fish/config.fish && reset"
# Kill Shell History
  alias empty="clear && history --clear"
# Show directory sizes, depends on helper
  #alias dirsize="du -sk ./* | sort -n | AWKSIZE"
# More informative ls
  alias ll="ls -Alih --color"
# Show empty dirs
  alias l.emptydirs="ls -ld *(/^F)"
# Show symbolic links
  alias l.symbolic="find . -lname \"*\""
# Show last modified
  alias l.modified="ls -t $* 2> /dev/null | head -n 1"
# System
  alias dl="curl -O " #download
  alias psa="ps -eo pid,user,group,args,etime,lstart "
  alias psl="watch -n 1 ps -eo %cpu,pid,egid,user,group,args,etime,lstart,comm --sort=-%cpu,uid,-ppid,+pid "
  alias duff="du -hd 1 | sort -h"
  alias cmx="chmod +x "
  alias lsock="lsof -Pnl +M -i4"
# Show OS info
  alias 'is.os'="lsb_release -a;echo;cat /etc/*release;echo; cat /etc/issue*"
# List all zero-length-files which are not group- or world-writable
  alias 'is.empty'="ls *(L0f.go-w.)"
# Entropy / Portage
  alias e.q="equo match --multimatch --multirepo --installed"
  alias e.s="equo s "
  alias e.i="equo i --ask"
  alias e.rm="equo rm --ask"
  alias e.up="equo up && equo u --ask"
  alias e.sync="equo up ; layman -S ; eix-sync"
# Archive comfort
  alias set.targz="tar -cxvf"
  alias set.tarbzip2="tar --bzip2 -cvf"
  alias get.rfkills="rfkill list all"
  alias get.targz="tar -zxvf"
  alias get.tarbzip2="tar --bzip2 -xvf"
# Uncompress tar.bz2
  alias get.tarbz2="bzip2 -dc ${1} | tar -xf - "
# Show Userlist
  alias get.userlist='awk -F":" '"'"'{ print "username: " $1 "\t\tuid:" $3 }'"'"' /etc/passwd | column -t'
# Runners
  alias run.utf8="ex $1 \"+set ff=unix fileencoding=utf-8\" \"+x\""
  alias run.chmodFix=' for i in `find . -type d`; do  chmod 755 $i; done; for i in `find . -type f`; do  chmod 644 $i; done'
  alias run.chmodWWW=' for i in `find . -type d`; do  chmod 775 $i; done; for i in `find . -type f`; do  chmod 664 $i; done'
  alias run.plasma-again="kbuildsycoca4 2>/dev/null && kquitapp plasma-desktop 2>/dev/null ; kstart plasma-desktop > /dev/null 2>&1"
  alias run.update-fonts="fc-cache -f -r -v" #update font cache
  alias run.update-system-fonts="set -x PERSONAL_FONTS=$HOME/.fonts && echo \"Scanning $PERSONAL_FONTS\"; sudo fc-cache -f -r -v $PERSONAL_FONTS; sudo texhash; sudo mktexlsr; sudo updmap-sys --force"
  alias run.mysqldump="mysqldump --all-databases -p | bzip2 -c > $(date --rfc-3339=date)all-databases.sql.bz2"
# Proxy: Start to unblock stuff through your proxy
  alias 'on.proxy'="PORT=$[${RANDOM}%2012+4012]; echo -n 'Enter Hostname: '; read HOSTNAME; ssh -C2 -c blowfish -D $PORT $HOSTNAME sleep 5; echo 'Your proxy runs on: localhost:${PORT} forwarded through ${HOSTNAME}'"
# Proxy: kills all users using ssh with given username to end proxy session
  alias 'off.proxy'="read USER; kill $(ps ax o 'pid euser egroup command' | grep "sshd: $USER" | awk '{ print $1 }' | sed ':a;N;$!ba;s/\n/ /g') > /dev/null"
# WiFi
  alias w.scan="iwlist wlan0 scan >/dev/null "
  alias w.up="ifconfig wlan0 up"
  alias w.down="ifconfig wlan0 down"
  alias w.reload="rmmod iwldvm && rmmod iwlwifi && sleep 1;modprobe iwlwifi auto_agg=0 wd_disable=1 bt_coex_active=0 && sleep 1 modprobe iwldvm"