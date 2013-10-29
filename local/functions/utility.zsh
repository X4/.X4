## Make Bash's builtin help work in ZSH
## - Usage: help getopts
function bash-help() { bash -c "help $@" ;}

# Fast check for a program's existance
program_exists() {
    local ret='0'
    type $1 >/dev/null 2>&1 || { local ret='1'; }

    # throw error on non-zero return value
    if [ ! "$ret" -eq '0' ]; then
    error "$2"
    fi
}

