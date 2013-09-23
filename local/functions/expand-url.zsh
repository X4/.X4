## Resolve URL to its final destination (after redirects, etc):
## - expand-url "http://portal.camera.calit2.net"
function furl() { 
  wget -q -U "Mozilla/5" -O/dev/null -S $@ 2>&1 | \
    awk '{if($1~/^Location:/){print $2}}'
}