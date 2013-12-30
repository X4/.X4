##########################
#   LIST OF LANGUAGES    #
##########################
# af    (Afrikaans)      #
# sq    (Albanian)       #
# ar    (Arabic)         #
# hy    (Armenian)       #
# az    (Azerbaijani)    #
# eu    (Basque)         #
# be    (Belarusian)     #
# bn    (Bengali)        #
# bg    (Bulgarian)      #
# ca    (Catalan)        #
# zh-CN (Chinese)        #
# hr    (Croatian)       #
# cs    (Czech)          #
# da    (Danish)         #
# nl    (Dutch)          #
# en    (English)        #
# eo    (Esperanto)      #
# et    (Estonian)       #
# tl    (Filipino)       #
# fi    (Finnish)        #
# fr    (French)         #
# gl    (Galician)       #
# ka    (Georgian)       #
# de    (German)         #
# el    (Greek)          #
# gu    (Gujarati)       #
# ht    (Haitian-Creole) #
# iw    (Hebrew)         #
# hi    (Hindi)          #
# hu    (Hungarian)      #
# is    (Icelandic)      #
# id    (Indonesian)     #
# ga    (Irish)          #
# it    (Italian)        #
# ja    (Japanese)       #
# kn    (Kannada)        #
# ko    (Korean)         #
# la    (Latin)          #
# lv    (Latvian)        #
# lt    (Lithuanian)     #
# mk    (Macedonian)     #
# ms    (Malay)          #
# mt    (Maltese)        #
# no    (Norwegian)      #
# fa    (Persian)        #
# pl    (Polish)         #
# pt    (Portuguese)     #
# ro    (Romanian)       #
# ru    (Russian)        #
# sr    (Serbian)        #
# sk    (Slovak)         #
# sl    (Slovenian)      #
# es    (Spanish)        #
# sw    (Swahili)        #
# sv    (Swedish)        #
# ta    (Tamil)          #
# te    (Telugu)         #
# th    (Thai)           #
# tr    (Turkish)        #
# uk    (Ukrainian)      #
# ur    (Urdu)           #
# vi    (Vietnamese)     #
# cy    (Welsh)          #
# yi    (Yiddish)        #
##########################

UA="Mozilla/5.0"
#UA='Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.66 Safari/537.36'
#UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.65 Safari/537.31"

function json_decode() {
    if [[ -z "$1" ]]; then
            perl -MJSON -e '$json = decode_json($1);  print $json'
    fi
}

function sanitize() {
    echo "$1" \
    | perl -ple "s/\033\[(?:\d*(?:;\d+)*)*m//g;"  \
    | perl -MURI::Escape -ne "\$/=\"\"; print uri_escape \$_"
}

# Play the computer synthethized pronounciation of a translation
function dicsay() {
    mplayer -user-agent Mozilla \
    "http://translate.google.com/translate_tts?tl=${2:-en}&q=$(sanitize ${1} | sed 's#\ #\+#g')" >|/dev/null 2>&1
}

function dicspeak() {
    LONGEST_TEXT=100
    LANGUAGE="${2:-en}"
    GOOGLE_URL="http://translate.google.com/translate_tts?tl=$LANGUAGE&q="

    if [ "$1" == "" -o "$2" == "" -o "$3" =="" ]; then
        echo "Usage: ./text2mp3.sh [directory] [text]"
    fi

    basedir=$1
    exec 6>&1           # Link file descriptor #6 with stdout.
    exec &> /dev/null   # stdout replaced with file "logfile.txt".

    checksum=`echo ${*:2} | openssl md5 | sed 's/^.* //'`

    echo "Checksum [$checksum] for text [${*:3}]"

    #filename needs to be wav, sox has no mp3 mixing support
    filename="$checksum.wav"
    if [ -f $basedir/$filename ]; then
        exec 1>&6 6>&-      # Restore stdout and close file descriptor #6.
        echo $filename
    fi

    text=""
    #number starts in 1000 to avoid lexical rearrangements
    slice=1000
    files=()
    for word in ${*:3}; do
        length=`expr ${#text} + ${#word} + 1`
        if [ $length -gt $LONGEST_TEXT ]; then
            slice+=1
            echo "Splitting text [$text] for slice $slice"
            splitfile="$basedir/$checksum$slice.mp3"
            files=("${files[@]}" $splitfile)
            wget -U "$UA" -O $splitfile "$GOOGLE_URL$text"
            text=$word
        else
        text+=" "$word
        fi
    done;

    if [ ${#text} -gt 0 ]; then
        slice+=1
        splitfile="$basedir/$checksum$slice.mp3"
        wget  -U "$UA" -O $splitfile "$GOOGLE_URL$text"
        files=("${files[@]}" $splitfile)
    fi

    IFS=" "
    sox --combine sequence ${files[*]} $basedir/$filename
    #TODO: output format consideration
    #lame -v -m m -B 48 -s 44.1 input.wav output.mp3
    exec 1>&6 6>&-      # Restore stdout and close file descriptor #6.
    #echo $filename
    for f in $files; do
        rm -f $f
    done;
    play $basedir/$filename
    #rm -f "$basedir/$filename"
}

# Just translate from a to b
function dic() {
    if [[ -z "$1" ]]; then
        echo "$0 simply translates your input to any language specified."
        echo "Usage: $0 source-word(s) source-language target-language" # TODO: number-of-examples
    else
        wget -U $UA -qO - \
        "http://translate.google.com/translate_a/t?client=t&text=$(sanitize ${1})&sl=${3:-auto}&tl=${2:-en}" \
        | sed 's/\[\[\[\"//' \
        | cut -d \" -f 1
    fi
}

# Translate word(s) and show example sentences containing it
function dicx() {
    if [[ -z "$1" ]]; then
        echo "$0 get example sentences in the other language from your source-word(s)."
        echo "Usage: $0 source-words(s) source-language target-language number-of-examples"
    else
        json_decode $(wget -U $UA -qO - \
        "http://translate.google.de/translate_a/single?client=t&sl=${3:-auto}&tl=${2:-en}&hl=${2:-en}&dt=ex&q=$(sanitize ${1})")
    fi
}

# Translate word and speak it
function dics() {
    if [[ ! -z "$1" ]]; then
        dic "$1" $3 $2
        dicspeak "/tmp" "$(dic $1 $3 $2)" $3
    else
        echo "$0 can translate and pronounce your input into many languages."
        echo "Usage: $0 <input> <source-language> <target-language>"
    fi
}

# Translate word and speak it
function dicc() {
    if [[ ! -z "$1" ]]; then
        dic "$1" $3 $2
        dicsay "$(dic $1 $3 $2)" $3
    else
        echo "$0 can translate and pronounce your input into many languages."
        echo "Usage: $0 <input> <source-language> <target-language>"
    fi
}

# Translate EN<->DE using dict.leo.org
function dict() {
    if [[ -z "$1" ]]; then
        echo "$0 uses dict.leo.org to translate your keywords."
        echo "Usage: $0 <keyword-1> <keyword-2>"
    else
        $HOME/.X4/local/scripts/leo.py ${1} ${2}
    fi
}

# Translate EN<->DE using dict.cc
function dictt() {
    NAME="dict.cc"; VERSION="1.0"; UA="${NAME}/${VERSION} (cli)";

    if [[ "x${1}" = "x" ]]; then
      echo "missing word."
      echo "USAGE:" $(basename $0) "WORD"
      return 1
    fi

    echo "" > /tmp/dict
    SITE="$(wget --user-agent="${UA}" -q -O - "http://www.dict.cc/?s=${1}")"
    echo "\e[32m[English]\033[0m"
    echo "${SITE}" | grep "var c1Arr = new Array" | cut -d '(' -f2 | cut -d ')' -f1 | sed "s/,/\n/g" | sed "s/\"//g" | grep -v "^$" | sed "s/^/\t/" | nl -s "."

    echo "\e[32m[Deutsch]\033[0m"
    echo "${SITE}" | grep "var c2Arr = new Array" | cut -d '(' -f2 | cut -d ')' -f1 | sed "s/,/\n/g" | sed "s/\"//g" | grep -v "^$" | sed "s/^/\t/" | nl -s "."
}


# Search words that begin with
function words() {
    if [[ -z "$1" ]]; then
        echo "$0 looks up similar words for you."
        echo "Usage: $0 <keyword>"
    else
        grep "$@" /usr/share/dict/words
    fi
}
