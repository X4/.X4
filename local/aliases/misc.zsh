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
  alias cls=" clear;exec $SHELL"
# Kill Shell History
  alias empty="clear && history --clear"
# Show directory sizes, depends on helper
  #alias dirsize="du -sk ./* | sort -n | AWKSIZE"
# Show last modified
  alias l.modified="ls -t $* 2> /dev/null | head -n 1"
# System
  alias dl="curl -O "
  alias ps.all="ps -eo pid,user,group,args,etime,lstart "
  alias ps.list="watch -n 1 ps -eo %cpu,pid,egid,user,group,args,etime,lstart,comm --sort=-%cpu,uid,-ppid,+pid "
  alias duff="du -hd 1 | sort -h"
  alias cmx="chmod +x "
  alias get.rfkills="rfkill list all"
  alias get.socket="lsof -Pnl +M -i4"
# Show OS info
  alias get.os="lsb_release -a;echo;cat /etc/*release;echo; cat /etc/issue*"
# Show all font-families
alias get.fonts='fc-list :outline -f "%{family}\n"'
# List all zero-length-files which are not group- or world-writable
  alias l.zero="ls *(L0f.go-w.)"
# Archive comfort
  alias to.targz="tar -cxvf"
  alias to.tarbz2="tar --bzip2 -cvf"
  alias get.targz="tar -zxvf"
  alias get.tarbz2="tar --bzip2 -xvf"
# Uncompress tar.bz2
  alias get.tarbz2="bzip2 -dc ${1} | tar -xf - "
# Show Userlist
  alias get.userlist='awk -F":" '"'"'{ print "username: " $1 "\t\tuid:" $3 }'"'"' /etc/passwd | column -t'
# Runners
  alias to.utf8="ex $1 \"+set ff=unix fileencoding=utf-8\" \"+x\""
  alias run.chmodFix="find . -type d -print0 | xargs -0 chmod 755; find . -type f -print0 | xargs -0 chmod 644"
  alias run.plasma-again="kbuildsycoca4 2>/dev/null && kquitapp plasma-desktop 2>/dev/null ; kstart plasma-desktop > /dev/null 2>&1"
  alias run.update-fonts="fc-cache -f -r -v" #update font cache
  alias run.update-system-fonts="set -x PERSONAL_FONTS=$HOME/.fonts && echo \"Scanning $PERSONAL_FONTS\"; sudo fc-cache -f -r -v $PERSONAL_FONTS; sudo texhash; sudo mktexlsr; sudo updmap-sys --force"
  alias run.mysqldump="mysqldump --all-databases -p | bzip2 -c > $(date --rfc-3339=date)all-databases.sql.bz2"
# Proxy: Start to unblock stuff through your proxy
  alias proxy.on="PORT=$[${RANDOM}%2012+4012]; echo -n 'Enter Hostname: '; read HOSTNAME; ssh -C2 -c blowfish -D $PORT $HOSTNAME sleep 5; echo 'Your proxy runs on: localhost:${PORT} forwarded through ${HOSTNAME}'"
# Proxy: kills all users using ssh with given username to end proxy session
  alias proxy.off="read USER; kill $(ps ax o 'pid euser egroup command' | grep "sshd: $USER" | awk '{ print $1 }' | sed ':a;N;$!ba;s/\n/ /g') > /dev/null"
# WiFi
  alias wifi.scan="iwlist wlan0 scan >/dev/null "
  alias wifi.up="ifconfig wlan0 up"
  alias wifi.down="ifconfig wlan0 down"
  alias wifi.reload="rmmod iwldvm && rmmod iwlwifi && sleep 1;modprobe iwlwifi auto_agg=0 wd_disable=1 bt_coex_active=0 && sleep 1 modprobe iwldvm"