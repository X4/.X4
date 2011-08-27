# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#export ZSH_THEME="robbyrussell"
export ZSH_THEME="jtriley"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(rvm rails3 ruby bundler git npm node git git-flow debian deb)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/local/sbin:/usr/sbin:/sbin

alias -g cls='source ~/.zshrc && reset'
alias -g hue='tar -cvf fdgr46.tar fdgr46 && gzip fdgr46.tar'
alias -g empty='clear && history -p'
alias -g dl='curl -O '
alias -g h='ls -Alih --color'
alias -g c='gcc -Wall -ansi -pedantic -g -o '
alias -g git-sub='git submodule init && git submodule update'
alias -g rorv='which ruby;which rails;which bundle;ruby -v;rails -v; bundle -v'
alias -g update-fonts='fc-cache -f -r -v'
alias -g upp='sudo apt-get update > /dev/null &'
alias -g ri='rvm exec ri '
alias -g mongodb='mkdir /tmp/mongo -p && mongod --dbpath /tmp/mongo --rest > /dev/null &'
alias -g hamilize="find . -name '*erb' | xargs ruby -e 'ARGV.each { |i| puts \"html2haml -r #{i} #{i.sub(/erb$/,\"haml\")};rm #{i}\"}' | bash"
alias -g mount='mount | column -t'
alias -g l="ls -lahH --color --time-style long-iso | sed -e 's/--x/1/g' -e 's/-w-/2/g' -e 's/-wx/3/g' -e 's/r--/4/g' -e 's/r-x/5/g' -e 's/rw-/6/g' -e 's/rwx/7/g' -e 's/---/0/g'"
alias -g bb='bzip2 -dc ${1} | tar -xf - '
alias -g dims='identify -format %wx%h ${1}'
alias -g dirsize="du -sk ./* | sort -n | AWKSIZE"


AWKSIZE(){
awk 'BEGIN{ pref[1]="K"; pref[2]="M"; pref[3]="G";} { total = total + $1; x = $1; y = 1; while( x > 1024 ) { x = (x + 1023)/1024; y++; } printf("%g%s\t%s\n",int(x*10)/10,pref[y],$2); } END { y = 1; while( total > 1024 ) { total = (total + 1023)/1024; y++; } printf("Total: %g%s\n",int(total*10)/10,pref[y]); }'
}

wiki(){C=`tput cols`;dig +short txt ${1}.wp.dg.cx|sed -e 's/" "//g' -e 's/^"//g' -e 's/"$//g' -e 's/ http:/\n\nhttp:/'|fmt -w $C}
dict(){
NAME="dict.cc"; VERSION="1.0"; USERAGENT="${NAME}/${VERSION} (cli)";
 
if [[ "x${1}" = "x" ]]; then
  echo "missing word."
  echo "USAGE:" $(basename $0) "WORD"
  exit 1
fi

echo "" > /tmp/dict 
SITE="$(wget --user-agent="${USERAGENT}" -q -O - "http://www.dict.cc/?s=${1}")"
echo "ENGLISH"
echo "${SITE}" | grep "var c1Arr = new Array" | cut -d '(' -f2 | cut -d ')' -f1 | sed "s/,/\n/g" | sed "s/\"//g" | grep -v "^$" | sort | uniq | sed "s/^/\t/"| column | fold -s --width=120
echo "DEUTSCH"
echo "${SITE}" | grep "var c2Arr = new Array" | cut -d '(' -f2 | cut -d ')' -f1 | sed "s/,/\n/g" | sed "s/\"//g" | grep -v "^$" | sort | uniq | sed "s/^/\t/"| column | fold -s --width=120
}
 
# [[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm # Lokal install
[[ -s '/usr/local/rvm/scripts/rvm' ]] && source '/usr/local/rvm/scripts/rvm' # Global install

