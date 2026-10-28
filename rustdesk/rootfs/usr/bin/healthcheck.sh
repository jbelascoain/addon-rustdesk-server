#!/bin/sh
# Probe the ports hbbs/hbbr bind. Docker HEALTHCHECK cannot reliably
# talk to s6-supervise unix sockets under the add-on AppArmor profile,
# so s6-svstat reports failure while the daemons are actually up and
# Supervisor watchdog restart-loops the container.

check_listen() {
  port_hex=$(printf '%04X' "$1")
  grep -qE ":${port_hex} .* 0A " /proc/net/tcp \
    || grep -qE ":${port_hex} .* 0A " /proc/net/tcp6
}

check_listen 21116 || exit 1
check_listen 21117 || exit 1
exit 0
