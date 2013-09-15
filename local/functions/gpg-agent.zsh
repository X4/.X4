# start gpg-agent if it's not running
if [ -z "`pidof gpg-agent`" ]; then
    eval "$(gpg-agent --daemon --write-env-file --enable-ssh-support)"
fi;
# source gpg info
if [ -f "${HOME}/.gpg-agent-info" ]; then
    sed -i '/^[SG]/s/^/export /' "${HOME}/.gpg-agent-info"
    . "${HOME}/.gpg-agent-info"
fi; 
