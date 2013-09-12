# disable XON (^S) and XOFF (^Q) flow control keys
# http://blog.sanctum.geek.nz/terminal-annoyances/
stty -ixon

# disable pc-speaker beeps
setterm -bfreq 0