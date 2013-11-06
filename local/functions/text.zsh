function to.uppercase(){
    echo ${1} | tr 'a-zA-Z' 'A-Z'
}
function to.uppercase(){
    echo ${1} | tr 'a-zA-Z' 'a-z'
}

# print only the given columns, numbered from 1 to N
function print.col() { 
  awk "{ print $(for n; do echo -n "\$$n,"; done | sed 's/,$//') }"
}

# Lists the ten most used commands
function h.top(){
    history 0 | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head
}

# Lists the rate at which commands are used
function h.rate() {
  history 0 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n20
}

# List all occurences of command in history
function h.of() {
    if [ -z "$*" ]; then
        history 1
    else
        history 1 | egrep "$@" | less
    fi
}

