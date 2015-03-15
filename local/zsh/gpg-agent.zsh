# start gpg-agent if it's not running
if [ -z "`pidof gpg-agent`" ]; then
    eval "$(gpg-agent -s --daemon --write-env-file --enable-ssh-support --pinentry-program=/usr/bin/pinentry-qt4)"
fi;
# source gpg info
if [ -f "${HOME}/.gpg-agent-info" ]; then
    sed -i '/^[SG]/s/^/export /' "${HOME}/.gpg-agent-info"
    . "${HOME}/.gpg-agent-info"
fi; 
