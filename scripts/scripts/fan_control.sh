#!/usr/bin/env bash

set -euo pipefail

FANS=(
  /sys/class/hwmon/hwmon4/pwm{1..7}
  /sys/class/hwmon/hwmon5/pwm{1..5}
  /sys/class/hwmon/hwmon5/pwm7
)

set_all() {
  local value=$1
  for fan in "${FANS[@]}"; do
    echo 1 > "${fan}_enable"
    echo "$value" > "$fan"
  done
}

# only change speed if current rpm is not zero
# this way avoiding setting unnecessary fans in my specific
# pc fan configuration
set_active_full() {
  for fan in "${FANS[@]}"; do
    local num="${fan##*pwm}"
    local rpm_file="$(dirname "$fan")/fan${num}_input"
    if [ -f "$rpm_file" ] && [ "$(cat "$rpm_file")" -gt 0 ]; then
      echo 1 > "${fan}_enable"
      echo 255 > "$fan"
    fi
  done
}

case "${1:-}" in
  zero)   set_all 0   ;;
  mid) set_all 128 ;;
  full)   set_active_full ;;
  auto)
    for fan in "${FANS[@]}"; do
      echo 2 > "${fan}_enable"
    done
    ;;
  *)
    echo "Usage: $(basename "$0") {zero|mid|full|auto}"
    exit 1
    ;;
esac
