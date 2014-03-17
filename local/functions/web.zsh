## Resolve URL to its final destination (after redirects, etc):
## - url.expand "http://portal.camera.calit2.net"
function url.expand() {
  wget -q -U "Mozilla/5" -O/dev/null -S $@ 2>&1 | \
    awk '{if($1~/^Location:/){print $2}}'
}

## Dig for all available DNS records
## - Usage: dig.all ns1.crbs.ucsd.edu
dig.all() {
    dig +nocmd $1 any +multiline +noall +answer
}

# Retrieve BibTeX associated with DOI codes
function doi.bib() {
    echo $(curl -sLH "Accept: text/bibliography; style=bibtex" http://dx.doi.org/${1};) | sed -e 's/,/,\n/g' -e '0,/{/{s/{/ {\n/}' -e 's/\(.*\)}/\1\n}/'
}

# Proxy: Start to unblock stuff through your proxy
function proxy.on() {
    "PORT=$[${RANDOM}%2012+4012]; echo -n 'Enter Hostname: '; read HOSTNAME; ssh -C2 -c blowfish -D $PORT $HOSTNAME sleep 5; echo 'Your proxy runs on: localhost:${PORT} forwarded through ${HOSTNAME}'"
}

# Proxy: kills all users using ssh with given username to end proxy session
function proxy.off() {
    "read USER; kill $(ps ax o 'pid euser egroup command' | grep "sshd: $USER" | awk '{ print $1 }' | sed ':a;N;$!ba;s/\n/ /g') > /dev/null"
}

function myip () {
    curl http://ipecho.net/plain; echo;
}