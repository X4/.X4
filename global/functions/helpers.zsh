#start()   { for arg in $*; do sudo /etc/rc.d/rc.$arg start;   done }
#stop()    { for arg in $*; do sudo /etc/rc.d/rc.$arg stop;    done }
#restart() { for arg in $*; do sudo /etc/rc.d/rc.$arg restart; done }
#run()     { for arg in $*; do sudo /etc/rc.d/rc.$arg run;     done }
#test()    { for arg in $*; do sudo /etc/rc.d/rc.$arg test;    done }
#status()  { for arg in $*; do sudo /etc/rc.d/rc.$arg status;  done }

# print hex value of a number
hex() {
    emulate -L zsh
    if [[ -n "$1" ]]; then
        printf "%x\n" $1
    else
        print 'Usage: hex <number-to-convert>'
        return 1
    fi
}

# Find out which libs define a symbol
lcheck() {
    if [[ -n "$1" ]] ; then
        nm -go /usr/lib/lib*.a 2>/dev/null | grep ":[[:xdigit:]]\{8\} . .*$1"
    else
        echo "Usage: lcheck <function>" >&2
    fi
}

# get image dimensions
imgres () {
for image in "$@"; do
  if [ ${image: -4} == ".txt" ]; then

    # use identify to get the size in format "width height"
    size="$(identify -format "%w %h" "$image")"

    # extract width from the string by 'cutting off' everything
    # from the first space on (or up to the first space(see string manipulations)
    width="${size%% *}"

    # extract height
    height="${size##* }" 

    # use bash math to compare the numbers
    if ((width*height>maxsize)); then
        echo "$fname";
    fi
  fi
#	identify -format '%f is a %zbit %C compressed %m with %G@%nfps AND %wx%h\n' "$@" | sort -u | tr -s '\n';
done
}

# show weather
function show_weather() {
   curl --silent "http://xml.weather.yahoo.com/forecastrss?p=GMXX0260&u=c" | grep -E '(Current Conditions:| C<BR)' | sed -e 's/Current Conditions://' -e 's/<br \/>//' -e 's/<b>//' -e 's/<\/b>//' -e 's/<BR \/>//g' -e 's/<description>//' -e 's/<\/description>//' -e 's/Drifting Snow/Schneeverwehungen/g' -e 's/Fair/Heiter/g' -e 's/Haze/Nebel/g' -e 's/Partly/Zum Teil/g' -e 's/Sunny/Sonnig/g' -e 's/Mostly/Meist/g' -e 's/Heavy/Starker/g' -e 's/Light/Leichter/g' -e 's/Rain Shower/Regenschauer/g' -e 's/Rain/Regen/g' -e 's/Showers/Schauer/g' -e 's/T-showers/Gewitter/g' -e 's/Thundershower/Gewitterschauer/g' -e 's/Mostly/Meist/g' -e 's/Scattered/Vereinzelt/g' -e 's/Showers Late/Abends Schauer/g' -e 's/Shower/Schauer/g' -e 's/Showers in the Vicinity/Schauer in der Umgebung/g' -e 's/AM/vormittags/g' -e 's/PM/nachmittags/g' -e 's/Clear/Klar/g' -e 's/Cloudy/bewÃ¶lkt/g' -e 's/Windy/windig/g' -e 's/Few/Wenige/g' -e 's/Thunderstorm/Gewittersturm/g' -e 's/Thunder/Gewitter/g' -e 's/Snow/Schnee/g' -e 's/Fog/Nebel/g' -e 's/Early/Morgens/g' -e 's/Late/Abends/g' -e 's/Drizzle/Nieselregen/g' -e 's/Isolated/Vereinzelt/g' -e 's/Mix/Wechselhaft/g' -e 's/Wintry/Winterlich/g' -e 's/to/oder/g' -e 's/in the Vicinity/in der Umgebung/g' -e 's/Mist/Leichter Nebel/g' -e 's/\ C$/\Â°C/' -e 's/,/ bei/g' -e 's/with/mit/g' | tail -1
}

#reconnect vpns
autovpn(){
    while [ 1 ]; do
       echo -n $(date) "##  "
       sudo $HOME/.X4/functions/autovpn
       sleep 3
    done
}

#chkservice control services
chkservice(){
	sudo $HOME/.X4/functions/chkservice
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

# convert to Upper-Case
toUpper() { echo $@ | tr "[:lower:]" "[:upper:]"; }

# currency conversion
currency() {
	if [ $# -eq 2 ]
	then
	  NUM=1;CURRENCY1=$(toUpper "$1"); CURRENCY2=$(toUpper "$2")
	elif [ $# -eq 3 ]
	then
	  NUM=$1;CURRENCY1=$(toUpper "$2"); CURRENCY2=$(toUpper "$3")
	else
	  echo "Usage: $0 [number] currency1 currency2"
	  echo "Ex: $0 100 EUR USD"
	  echo "Available currencies: EUR, USD, GBP, JPY, CHF, CAD, AUD, INR"
	fi

	CONVERSION=`wget -nv -O - "http://finance.google.com/finance?q=$CURRENCY1$CURRENCY2" 2>&1 | \
		grep "&nbsp;1&nbsp;$CURRENCY1&nbsp;" | \
		sed -e "s/^.*<span class=bld>&nbsp;\(.*\)&nbsp;$CURRENCY2.*$/\1/"`

	if [ ${CONVERSION:-1} == "1" ]
	then
	  echo "Network error"
	else
	  RESULT=$(echo $CONVERSION \* $NUM | bc)
	  echo "$NUM $CURRENCY1 = $RESULT $CURRENCY2"
	fi
}


AWKSIZE(){
    awk 'BEGIN{ pref[1]="K"; pref[2]="M"; pref[3]="G";} { total = total + $1; x = $1; y = 1; while( x > 1024 ) { x = (x + 1023)/1024; y++; } printf("%g%s\t%s\n",int(x*10)/10,pref[y],$2); } END { y = 1; while( total > 1024 ) { total = (total + 1023)/1024; y++; } printf("Total: %g%s\n",int(total*10)/10,pref[y]); }'
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
