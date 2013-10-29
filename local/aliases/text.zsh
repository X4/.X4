print.col() { # print only the given columns, numbered from 1 to N
  awk "{ print $(for n; do echo -n "\$$n,"; done | sed 's/,$//') }"
}

alias puts='print -l'
alias grep='grep --color'

# Lists the ten most used commands.
alias history.stats="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"

function history.rate() {
  history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n20
}