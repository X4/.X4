# Lists
  alias l.modified="ls -t $* 2> /dev/null | head -n 1"
  alias l.socket="lsof -Pnl +M -i4"
  alias l.users='awk -F":" '"'"'{ print "username: " $1 "\t\tuid:" $3 }'"'"' /etc/passwd | column -t'
# List all empty files which are not group- or world-writable
  alias l.zero="ls *(L0f.go-w.)"

# Processes
  alias p.all='ps -eo pid,user,group,args,etime,lstart'
  alias p.list='watch -n 1 ps -eo %cpu,pid,egid,user,group,args,etime,lstart,comm --sort=-%cpu,uid,-ppid,+pid '

# Convert
  alias to.utf8="ex $1 \"+set ff=unix fileencoding=utf-8\" \"+x\""
  alias to.chmodFix="find . -type d -print0 | xargs -0 chmod 755; find . -type f -print0 | xargs -0 chmod 644"

