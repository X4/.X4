# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="robbyrussell"

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
plugins=(rvm rails3 ruby bundler git npm node git git-flow debian deb history-substring-search extract compleat)

source $ZSH/oh-my-zsh.sh
#source $HOME/.X4/.zsh_theme

# Customize to your needs...
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/local/sbin:/usr/sbin:/sbin

#########################################
# Aliases and Functions only
#########################################

# Enhancements
alias mount='mount | column -t' #prettyfy mounted filesystems
alias dims='identify -format %wx%h ${1}' #get image dimensions
alias dirsize="du -sk ./* | sort -n | AWKSIZE" #show directory sizes
alias favs="history | awk '{print $2}' | sort | uniq -c | sort -rn | head" #show favorite commands

# Show / Find
alias h='ls -Alih --color' #more informative ls
alias l="ls -alhgGd .* --color 2> /dev/null | awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\" %0o \",k);print}' && ls -lhgG --color | awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\" %0o \",k);print}'" # show oktal permissions
alias le="ls -ld *(/^F)" #show empty dirs

# GIT
alias git-sub='git submodule init && git submodule update' #update all git submodules
alias g='git'
alias gl='git pull --rebase'
alias gp='git push'
alias gpa='git push -u origin master'
alias ga='git add'
alias gc='git commit'
alias gca='git commit -a'
alias gs='git status -sb'
alias gd='git diff'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias changelog='git --no-pager log --format="%ai %aN %n%n%x09* %s%d%n" > ChangeLog'
alias 'ga!'='find . -type d -empty -exec touch {}/.gitignore \;'

# Maintainance
alias cls='source ~/.zshrc && reset' #reload config and reset terminal
alias empty='clear && history -p' #kill history
alias savedb='mysqldump --all-databases -p | bzip2 -c > $(date --rfc-3339=date)fulldatabasebackup.sql.bz2'
alias 'os?'='lsb_release -a;echo;cat /etc/*release;echo; cat /etc/issue' #get os info
alias 'empty?'='ls *(L0f.go-w.)' #List all zero-length-files which are not group- or world-writable
alias update-fonts='fc-cache -f -r -v' #update font cache
alias userlist='awk -F":" '"'"'{ print "username: " $1 "\t\tuid:" $3 }'"'"' /etc/passwd'
alias chmodFix=' for i in `find . -type d`; do  chmod 755 $i; done; for i in `find . -type f`; do  chmod 644 $i; done'
alias chmodWWW=' for i in `find . -type d`; do  chmod 775 $i; done; for i in `find . -type f`; do  chmod 664 $i; done'


# Lazyness / Comfort
alias hue='tar -cvf fdgr46.tar fdgr46 && gzip fdgr46.tar' #finish homework
alias dl='curl -O ' #download
alias c='gcc -Wall -ansi -pedantic -g -o ' #compile C
alias bz='bzip2 -dc ${1} | tar -xf - ' #uncompress tar.bz2
alias mm='cp -u ~/.X4/Makefile .; make distclean > /dev/null && make; ./${PWD##*/}' #clean tmp files, compile and execute the ./current_directoryname. Works always thanks to my Generic Makefile
alias psa='ps -eo pid,user,group,args,etime,lstart '
alias yurl='mplayer -fs $(curl -s "http://www.youtube.com/get_video_info?&video_id=$0" | echo -e $(sed "s/%/\\x/g;s/.*\(v[0-9]\.lscache.*\)/http:\/\/\1/g") | grep -oP "^[^|,]*")'

# Ruby / Rails
alias rorv='which ruby;which rails;which bundle;ruby -v;rails -v; bundle -v' #show ror version numbers
alias mongodb='mkdir /tmp/mongo -p && mongod --dbpath /tmp/mongo --rest > /dev/null &' #start mongodb
alias hamilize="find . -name '*erb' | xargs ruby -e 'ARGV.each { |i| puts \"html2haml -r #{i} #{i.sub(/erb$/,\"haml\")};rm #{i}\"}' | bash" #erb2haml



# Shell Functions

#update G-WAN
update-gwan(){
cd "$HOME/.gwan"
if [[ ! -f gwan_linux.tar.bz2 ]]; then
        wget -N "gwan.ch/archives/gwan_linux.tar.bz2" 2>/dev/null
else
        newfilesum=$(wget -NP $HOME/.gwan 'gwan.ch/archives/gwan_linux.tar.bz2' 2>/dev/null | sha256sum gwan_linux.tar.bz2 2>/dev/null)
        oldfilesum=$(sha256sum gwan_linux.tar.bz2 2>/dev/null)

        if [[ $newfilesum != $oldfilesum ]]; then
                # Backup local G-WAN installation
                tar cfj "$HOME/.gwan/gwan.$(date --iso).tar.bz2" "/usr/local/gwan"

                # Decompress new G-WAN archive
                tar xjf gwan_linux.tar.bz2

                # Update local G-WAN installation with new files
                sudo mv -f "$HOME/.gwan/gwan/" "/usr/local/gwan"
        else
                /usr/local/gwan/gwan -v | tr '\n' ' ' | echo -n "You're running "
        fi
fi
}

#ask wikipedia
wiki(){
    C=`tput cols`;dig +short txt ${1}.wp.dg.cx|sed -e 's/" "//g' -e 's/^"//g' -e 's/"$//g' -e 's/ http:/\n\nhttp:/'|fmt -w $C
}

#translate EN<->DE
dict(){
    NAME="dict.cc"; VERSION="1.0"; USERAGENT="${NAME}/${VERSION} (cli)";

    if [[ "x${1}" = "x" ]]; then
      echo "missing word."
      echo "USAGE:" $(basename $0) "WORD"
      return 1
    fi

    echo "" > /tmp/dict
    SITE="$(wget --user-agent="${USERAGENT}" -q -O - "http://www.dict.cc/?s=${1}")"
    echo "ENGLISH"
    echo "${SITE}" | grep "var c1Arr = new Array" | cut -d '(' -f2 | cut -d ')' -f1 | sed "s/,/\n/g" | sed "s/\"//g" | grep -v "^$" | uniq | sed "s/^/\t/"| column | fold -s --width=120
    echo "DEUTSCH"
    echo "${SITE}" | grep "var c2Arr = new Array" | cut -d '(' -f2 | cut -d ')' -f1 | sed "s/,/\n/g" | sed "s/\"//g" | grep -v "^$" | uniq | sed "s/^/\t/"| column | fold -s --width=120
}

#easier archive extraction
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1        ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1       ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1     ;;
            *.tar)       tar xvf $1        ;;
            *.tbz2)      tar xvjf $1      ;;
            *.tgz)       tar xvzf $1       ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1    ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

AWKSIZE(){
    awk 'BEGIN{ pref[1]="K"; pref[2]="M"; pref[3]="G";} { total = total + $1; x = $1; y = 1; while( x > 1024 ) { x = (x + 1023)/1024; y++; } printf("%g%s\t%s\n",int(x*10)/10,pref[y],$2); } END { y = 1; while( total > 1024 ) { total = (total + 1023)/1024; y++; } printf("Total: %g%s\n",int(total*10)/10,pref[y]); }'
}

xplot() {
    TMP="/tmp/gnuplot.tmp"
    if [ $# != 0 ];
    then
        echo "set title \"Xplot Fast Plot with gnuplot\" ." > $TMP
        echo "set xlabel \"x axes\"" >> $TMP
        echo "set ylabel \"y axez\"" >> $TMP
        echo -n "plot \"$1\" " >> $TMP
        for i in $@
        do
        if [ $i != $1 ];then
            echo -n "$i " >> $TMP
        fi
        done
        echo "">>$TMP
        gnuplot -persist $TMP
        rm $TMP
    else
        echo "Please use xplot <file.dat> <options> to plot"
    return 1
    fi
}


vgaswitch() {
# version 20101107

pci_integrated=$(lspci | grep VGA | sed -n '1p' | cut -f 1 -d " ")
pci_discrete=$(lspci | grep VGA | sed -n '2p' | cut -f 1 -d " ")

integrated=$(cat /sys/kernel/debug/vgaswitcheroo/switch | grep $pci_integrated | grep -o -P ':.:...:')
discrete=$(cat /sys/kernel/debug/vgaswitcheroo/switch | grep $pci_discrete | grep -o -P ':.:...:')

name_integrated=$(lspci | grep VGA | sed -n '1p' | sed -e "s/.* VGA compatible controller[ :]*//g" | sed -e "s/ Corporation//g" | sed -e "s/ Technologies Inc//g" | sed -e 's/\[[0-9]*\]: //g' | sed -e 's/\[[0-9:a-z]*\]//g' | sed -e 's/(rev [a-z0-9]*)//g' | sed -e "s/ Integrated Graphics Controller//g")

name_discrete=$(lspci | grep VGA | sed -n '2p' | sed -e "s/.* VGA compatible controller[ :]*//g" | sed -e "s/ Corporation//g" | sed -e "s/ Technologies Inc//g" | sed -e 's/\[[0-9]*\]: //g' | sed -e 's/\[[0-9:a-z]*\]//g' | sed -e 's/(rev [a-z0-9]*)//g' | sed -e "s/ Integrated Graphics Controller//g")

if [ "$integrated" = ":+:Pwr:" ]
then
 integrated_condition="(*) - Power ON"
elif [ "$integrated" = ": :Pwr:" ]
then
 integrated_condition="( ) - Power ON"
elif [ "$integrated" = ": :Off:" ]
then
 integrated_condition="( ) - Power OFF"
fi

if [ "$discrete" = ":+:Pwr:" ]
then
 discrete_condition="(*) - Power ON"
elif [ "$discrete" = ": :Pwr:" ]
then
 discrete_condition="( ) - Power ON"
elif [ "$discrete" = ": :Off:" ]
then
 discrete_condition="( ) - Power OFF"
fi

gxmessage -center \
          -buttons "_Cancel":1,"switch to _Integrated":101,"switch to _Discrete":102 \
          -wrap \
          -title "Choose Hybrid Graphic Card" \
"Choose Hybrid Graphic Card
=================
Integrated: $integrated_condition : $name_integrated
Discrete: $discrete_condition : $name_discrete"


whichCard=$?

case "$whichCard" in

1)
 echo "Exit"
;;
101)
 if [ "$integrated" == ":+:Pwr:" ] && [ "$discrete" == ": :Pwr:" ]
 then
  notify-send -t 5000 --icon="/home/$USER/.local/share/icons/hardware_down.png" "switching to $name_integrated"
  echo OFF > /sys/kernel/debug/vgaswitcheroo/switch
 elif [ "$integrated" == ": :Pwr:" ] && [ "$discrete" == ":+:Pwr:" ]
 then
  notify-send -t 5000 --icon="/home/$USER/.local/share/icons/hardware_down.png" "switching to $name_integrated"
  echo DIGD > /sys/kernel/debug/vgaswitcheroo/switch
  if [ "$DESKTOP_SESSION" = "openbox" ]
  then
   killall -u "$USER"
  elif [ "$DESKTOP_SESSION" = "gnome" ]
  then
   gnome-session-save --logout
  fi
 elif [ "$integrated" == ": :Off:" ] && [ "$discrete" == ":+:Pwr:" ]
 then
  notify-send -t 5000 --icon="/home/$USER/.local/share/icons/hardware_down.png" "switching to $name_integrated"
  echo ON > /sys/kernel/debug/vgaswitcheroo/switch
  echo DIGD > /sys/kernel/debug/vgaswitcheroo/switch
  if [ "$DESKTOP_SESSION" = "openbox" ]
  then
   killall -u "$USER"
  elif [ "$DESKTOP_SESSION" = "gnome" ]
  then
   gnome-session-save --logout
  fi
 elif [ "$integrated" == ":+:Pwr:" ] && [ "$discrete" == ": :Off:" ]
 then
  notify-send -t 5000 --icon="/home/$USER/.local/share/icons/hardware_down.png" "already switched to $name_integrated"
 fi
;;
102)
 if [ "$integrated" == ":+:Pwr:" ] && [ "$discrete" == ": :Pwr:" ]
 then
  notify-send -t 5000 --icon="/home/$USER/.local/share/icons/hardware_up.png" "switching to $name_discrete"
  echo DDIS > /sys/kernel/debug/vgaswitcheroo/switch
  if [ "$DESKTOP_SESSION" = "openbox" ]
  then
   killall -u "$USER"
  elif [ "$DESKTOP_SESSION" = "gnome" ]
  then
   gnome-session-save --logout
  fi
 elif [ "$integrated" == ": :Pwr:" ] && [ "$discrete" == ":+:Pwr:" ]
 then
  notify-send -t 5000 --icon="/home/$USER/.local/share/icons/hardware_up.png" "switching to $name_discrete"
  echo OFF > /sys/kernel/debug/vgaswitcheroo/switch
 elif [ "$integrated" == ":+:Pwr:" ] && [ "$discrete" == ": :Off:" ]
 then
  notify-send -t 5000 --icon="/home/$USER/.local/share/icons/hardware_up.png" "switching to $name_discrete"
  echo ON > /sys/kernel/debug/vgaswitcheroo/switch
  echo DDIS > /sys/kernel/debug/vgaswitcheroo/switch
  if [ "$DESKTOP_SESSION" = "openbox" ]
  then
   killall -u "$USER"
  elif [ "$DESKTOP_SESSION" = "gnome" ]
  then
   gnome-session-save --logout
  fi
 elif [ "$integrated" == ": :Off:" ] && [ "$discrete" == ":+:Pwr:" ]
 then
  notify-send -t 5000 --icon="/home/$USER/.local/share/icons/hardware_up.png" "already switched to $name_discrete"
 fi
;;
esac
}

debdep() {
if [[ -z "$1" ]]; then
  echo "Syntax: $0 debfile"
  return 1
fi

DEBFILE="$1"
TMPDIR=`mktemp -d /tmp/deb.XXXXXXXXXX` || return 1
OUTPUT=`basename "$DEBFILE" .deb`.modfied.deb

if [[ -e "$OUTPUT" ]]; then
  echo "$OUTPUT exists."
  rm -r "$TMPDIR"
  return 1
fi

dpkg-deb -x "$DEBFILE" "$TMPDIR"
dpkg-deb --control "$DEBFILE" "$TMPDIR"/DEBIAN

if [[ ! -e "$TMPDIR"/DEBIAN/control ]]; then
  echo DEBIAN/control not found.

  rm -r "$TMPDIR"
  return 1
fi

CONTROL="$TMPDIR"/DEBIAN/control

MOD=`stat -c "%y" "$CONTROL"`
vi "$CONTROL"

if [[ "$MOD" == `stat -c "%y" "$CONTROL"` ]]; then
  echo Not modfied.
else
  echo Building new deb...
  dpkg -b "$TMPDIR" "$OUTPUT"
fi

rm -r "$TMPDIR"
}


# [[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm # Lokal install
# [[ -s '/usr/local/rvm/scripts/rvm' ]] && source '/usr/local/rvm/scripts/rvm' # Global install
