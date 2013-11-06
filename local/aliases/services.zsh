# control systemd services
alias s.start="systemctl start"
alias s.stop="systemctl stop"
alias s.restart="systemctl restart"
alias s.status="systemctl status"

# control systemd unit files
alias s.available="systemctl list-unit-files"
alias s.enable="systemctl enable"
alias s.disable"systemctl disable"
alias s.services="systemctl list-units -t service"
alias s.dependencies="systemctl list-dependencies"
alias s.reload="systemctl daemon-reload"
alias s.reset="systemctl reset-failed"

# control pc status using systemd
alias pc.poweroff="systemctl poweroff"
alias pc.poweroff="systemctl reboot"
alias pc.poweroff="systemctl suspend"
alias pc.poweroff="systemctl hibernate"
alias pc.poweroff="systemctl hybrid-sleep"

# control journalctl
alias j.list="journalctl -xn --full"
alias j.catalog="journalctl --list-catalog"
alias j.force-rotation="systemctl kill --kill-who=main --signal=SIGUSR2 systemd-journald.service"
