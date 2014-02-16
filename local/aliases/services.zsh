# Control systemd services
  alias srv.start='systemctl start'
  alias srv.stop='systemctl stop'
  alias srv.restart='systemctl restart'
  alias srv.status='systemctl status'

# Control systemd unit files
  alias srv.available='systemctl list-unit-files'
  alias srv.enable='systemctl enable'
  alias srv.disable='systemctl disable'
  alias srv.services='systemctl list-units -t service'
  alias srv.dependencies='systemctl list-dependencies'
  alias srv.reload='systemctl daemon-reload'
  alias srv.reset='systemctl reset-failed'

# Control computer status using systemd
  alias pc.poweroff='systemctl poweroff'
  alias pc.reboot='systemctl reboot'
  alias pc.suspend='systemctl suspend'
  alias pc.hibernate='systemctl hibernate'
  alias pc.sleep='systemctl hybrid-sleep'

# Control journalctl
  alias log.list='journalctl -xn --full'
  alias log.catalog='journalctl --list-catalog'
  alias log.force-rotation='systemctl kill --kill-who=main --signal=SIGUSR2 systemd-journald.service'

# KDE shell controls
  alias kde.restart-plasma='kbuildsycoca4 2>/dev/null && kquitapp plasma-desktop 2>/dev/null ; kstart plasma-desktop > /dev/null 2>&1'

# System settings
  alias sys.update-fonts="fc-cache -f -r -v"
  alias sys.update-system-fonts="set -x PERSONAL_FONTS=$HOME/.fonts && echo \"Scanning $PERSONAL_FONTS\"; sudo fc-cache -f -r -v $PERSONAL_FONTS; sudo texhash; sudo mktexlsr; sudo updmap-sys --force"
  alias sys.fonts='fc-list :outline -f "%{family}\n"'

# WiFi
  alias wifi.scan='iwlist wlan0 scan >/dev/null'
  alias wifi.kill="wificurse -c $WIFI_CURSE"
  alias wifi.up='ifconfig wlan0 up'
  alias wifi.down='ifconfig wlan0 down'
  alias wifi.reload='rmmod iwldvm ; rmmod iwlwifi ; sleep 1;modprobe iwlwifi auto_agg=0 wd_disable=1 bt_coex_active=0 ; sleep 1; modprobe iwldvm'
  alias wifi.locks='rfkill list all'
