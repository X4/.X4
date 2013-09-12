# PulseAudio
alias s.sound.stop="pulseaudio -k --cleanup-shm > /dev/null"
alias s.sound.start="pulseaudio -D --realtime=1 > /dev/null"
alias s.sound.restart="pulseaudio -k > /dev/null ; killall kmix > /dev/null ; pulseaudio -D --realtime=1 > /dev/null ; kmix --keepvisibility & > /dev/null"

