export LESS='-iLR'
export PAGER='less'
export EDITOR='vim'
export VISUAL=$EDITOR
export BROWSER='w3m -v'

alias -g sudo="sudo "
alias e=$EDITOR
alias v=$PAGER
alias b=$BROWSER
alias ascii='man ascii'

alias scp='rsync --rsh=ssh -CarvP'
alias sloc='cloc --by-file-by-lang --exclude-dir .git'
alias diff='colordiff -u'

# Show history with timestamps
if [ "$HIST_STAMPS" = "mm/dd/yyyy" ]; then
    alias history='fc -fl 1'
elif [ "$HIST_STAMPS" = "dd.mm.yyyy" ]; then
    alias history='fc -El 1'
elif [ "$HIST_STAMPS" = "yyyy-mm-dd" ];then
    alias history='fc -il 1'
else
    alias history='fc -l 1'
fi
