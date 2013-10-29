# Rmate (TextMate)

# Install the rmate executable in ~/bin on the remote host
rmate-push() {
  local rhost="$1"
  local rmate_path="$(which rmate)"
  local rmate_url="https://raw.github.com/textmate/rmate/master/rmate"
  { [ ${rmate_path} ] && cat "$rmate_path" || curl "$rmate_url" ;} | 
    ssh $rhost "test -d ~/bin || mkdir ~/bin ; cat > ~/bin/rmate ; chmod +x ~/bin/rmate"
}

# Establish a tunnel between the remote host and local listening TextMate.app
rmate-tunnel() {
  local rhost="$1"
  local lport=$(defaults read com.macromates.TextMate.preview rmateServerPort 2>/dev/null | tr -d ',')
  local rport=52698
  ssh -q -N -R ${lport:-52698}:localhost:${rport} $rhost
}

## Replaced aliases...
# alias rmate-push="scp -p $(which rmate)"
# alias rmate-tunnel="ssh -q -N -R 52698:localhost:52698"