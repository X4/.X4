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

# strip ansi and urlencode input string
function sanitize() {
    echo "$1" \
    | perl -ple "s/\033\[(?:\d*(?:;\d+)*)*m//g;" \
    | perl -MURI::Escape -ne "\$/=\"\"; print uri_escape \$_"
}


function dicsay() {
    mplayer -user-agent Mozilla \
    "http://translate.google.com/translate_tts?tl=${2:-en}&q=$(sanitize ${1} | sed 's#\ #\+#g')" >|/dev/null 2>&1
}


function dic() {
    if [[ -z "$1" ]]; then
        echo "$0 simply translates your input to any language specified"
	echo "Usage: $0 source-language target-language"
    else
        wget -U $UA -qO - \
        "http://translate.google.com/translate_a/t?client=t&text=$(sanitize ${1})&sl=${3:-auto}&tl=${2:-en}" \
        | sed 's/\[\[\[\"//' \
        | cut -d \" -f 1
    fi
}


function dicc() {
    if [[ ! -z "$1" ]]; then
        dic $1 $3 $2
        dicsay $(dic $1 $3 $2) $3
    else
        echo "$0 can translate and pronounce your input into many languages."
	echo "Usage: $0 "<input>" <source-language> <target-language>"
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
    NAME="dict.cc"; VERSION="1.0"; USERAGENT="${NAME}/${VERSION} (cli)";

    if [[ "x${1}" = "x" ]]; then
      echo "missing word."
      echo "USAGE:" $(basename $0) "WORD"
      return 1
    fi

    echo "" > /tmp/dict
    SITE="$(wget --user-agent="${USERAGENT}" -q -O - "http://www.dict.cc/?s=${1}")"
    echo "\e[32m[English]\033[0m"
    echo "${SITE}" | grep "var c1Arr = new Array" | cut -d '(' -f2 | cut -d ')' -f1 | sed "s/,/\n/g" | sed "s/\"//g" | grep -v "^$" | uniq | sed "s/^/\t/" | nl -s "."

    echo "\e[32m[Deutsch]\033[0m"
    echo "${SITE}" | grep "var c2Arr = new Array" | cut -d '(' -f2 | cut -d ')' -f1 | sed "s/,/\n/g" | sed "s/\"//g" | grep -v "^$" | uniq | sed "s/^/\t/" | nl -s "."
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
