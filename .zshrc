# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS


# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
if [[ -e $HOME/.zsh_custom ]]; then
        source $HOME/.zsh_custom
fi

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Set a readable history time format
export HISTTIMEFORMAT='%F %T '

# How many lines of growth before rotating .zsh_history
ROTATEHIST=10000

# How many .zsh_history file rotations to keep
MAXHISTFILES=20

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(command-coloring git npm node git git-flow debian deb history-substring-search extract compleat taskwarrior)

source $ZSH/oh-my-zsh.sh

export CLICOLOR=true
export LESS="-erX"

# Customize to your needs...
export PATH=/usr/local/bin/ccache:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/local/sbin:/usr/sbin:/sbin

# Enhancements
alias mount='mount | column -t' #prettyfy mounted filesystems
alias dims='identify -format %wx%h ${1}' #get image dimensions
alias dirsize="du -sk ./* | sort -n | AWKSIZE" #show directory sizes
alias favs="history | awk '{print $2}' | sort | uniq -c | sort -rn | head" #show favorite commands
alias stay='tail -f'
alias bc='bc -q -l ~/.X4/.bcrc'

# Show / Find
alias h='ls -Alih --color' #more informative ls
alias l="noglob ls -alhd .* --color 2> /dev/null | awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\" %0o \",k);print}' && ls -lh --color | awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\" %0o \",k);print}'" # show oktal permissions
alias le='ls -ld *(/^F)' #show empty dirs
alias lm='ls -t $* 2> /dev/null | head -n 1' #show last modified
alias lsym='find . -lname "*"' #show symbolic links

# GIT
alias git-sub='git submodule init && git submodule update' #update all git submodules
alias g='git'
alias gl='git pull --rebase'
alias gp='git push'
alias gpa='git push -u origin master'
alias ga='git add'
alias gc='git commit'
alias gca='git commit -a'
alias gb='git branch'
alias gs='git status -sb'
alias gd='git diff'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias changelog='git --no-pager log --format="%ai %aN %n%n%x09* %s%d%n" | sed "s/\*\ \*/*/g" > ChangeLog'
alias 'ga!'='find . -type d -empty -exec touch {}/.gitignore \;'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gamend='git commit --amend -C HEAD'
alias gundo='git reset --soft HEAD^' # Undo your last commit, but don't throw away your changes
alias gredo='git reset --soft HEAD'
alias gtop="cat /home/git/.gitolite/logs/gitolite-`date +%Y-%m -d -30days`.log | cut -f2 | sort | uniq -c | sort -n -r"

# Maintainance
alias cls='source ~/.zshrc && reset' #reload config and reset terminal
alias empty='clear && history -p' #kill history
alias savedb='mysqldump --all-databases -p | bzip2 -c > $(date --rfc-3339=date)fulldatabasebackup.sql.bz2'
alias 'os?'='lsb_release -a;echo;cat /etc/*release;echo; cat /etc/issue*' #get os info
alias 'empty?'='ls *(L0f.go-w.)' #List all zero-length-files which are not group- or world-writable
alias update-fonts='fc-cache -f -r -v' #update font cache
alias userlist='awk -F":" '"'"'{ print "username: " $1 "\t\tuid:" $3 }'"'"' /etc/passwd | column -t'
alias chmodFix=' for i in `find . -type d`; do  chmod 755 $i; done; for i in `find . -type f`; do  chmod 644 $i; done'
alias chmodWWW=' for i in `find . -type d`; do  chmod 775 $i; done; for i in `find . -type f`; do  chmod 664 $i; done'
alias sstart='sudo service $0 start'
alias sstop='sudo service $0 stop'
alias sreload='sudo service $0 reload'
alias '1proxy'="PORT=$[${RANDOM}%2012+4012]; echo -n 'Enter Hostname: '; read HOSTNAME; ssh -C2 -c blowfish -D $PORT $HOSTNAME sleep 5; echo 'Your proxy runs on: localhost:${PORT} forwarded through ${HOSTNAME}'" # start with proxyme to unblock stuff through your proxy
alias '0proxy'="read USER; kill $(ps ax o 'pid euser egroup command' | grep "sshd: $USER" | awk '{ print $1 }' | sed ':a;N;$!ba;s/\n/ /g') > /dev/null" #kills all users using ssh with given username
alias lsock='lsof -Pnl +M -i4'

# Lazyness / Comfort
alias hue='git --no-pager log --format="%ai %aN %n%n%x09* %s%d%n" | sed "s/\*\ \*/*/g" > fdgr46/ChangeLog; tar -cvf fdgr46.tar fdgr46 && gzip fdgr46.tar' #finish homework
alias dl='curl -O ' #download
alias c='gcc -Wall -ansi -pedantic -g -o ' #compile C
alias cb='cp $0{,.orig}' #backup file to file.orig
alias bz='bzip2 -dc ${1} | tar -xf - ' #uncompress tar.bz2
alias mm='cp -u ~/.X4/Makefile .; make distclean > /dev/null && make; ./${PWD##*/}' #clean tmp files, compile and execute the ./current_directoryname. Works always thanks to my Generic Makefile
alias psa='ps -eo pid,user,group,args,etime,lstart '
alias targx="tar -zxvf"
alias targc="tar -cxvf"
alias tarbx="tar --bzip2 -xvf"
alias tarbc="tar --bzip2 -cvf"

# Ruby / Rails
alias rorv='which ruby;which rails;which bundle;ruby -v;rails -v; bundle -v' #show ror version numbers
alias mongodb='mkdir /tmp/mongo -p && mongod --dbpath /tmp/mongo --rest > /dev/null &' #start mongodb
alias hamilize="find . -name '*erb' | xargs ruby -e 'ARGV.each { |i| puts \"html2haml -r #{i} #{i.sub(/erb$/,\"haml\")};rm #{i}\"}' | bash" #erb2haml


#########################################
# Shell Functions
#########################################
source $HOME/.X4/functions/helpers
source $HOME/.X4/functions/vga_switch

# ZSH Tuning
source $HOME/.X4/functions/zsh_compile
