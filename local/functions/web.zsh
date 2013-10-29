## Resolve URL to its final destination (after redirects, etc):
## - expand-url "http://portal.camera.calit2.net"
function expand-url() { 
  wget -q -U "Mozilla/5" -O/dev/null -S $@ 2>&1 | \
    awk '{if($1~/^Location:/){print $2}}'
}

## Dig for all available DNS records
## - Usage: dig.all ns1.crbs.ucsd.edu
dig.all() {
    dig +nocmd $1 any +multiline +noall +answer
}
