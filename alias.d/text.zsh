col() { # print only the given columns, numbered from 1 to N
  awk "{ print $(for n; do echo -n "\$$n,"; done | sed 's/,$//') }"
}

alias puts='print -l'
alias grep='grep --color'

# Search words that begin with
words() {
  grep "$@" /usr/share/dict/words
}

# Lists the ten most used commands.
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"