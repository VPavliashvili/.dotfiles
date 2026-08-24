#!/usr/bin/env bash

{
  printf '[%s] Starting miracle session hook\n' "$(date '+%Y-%m-%d %H:%M:%S')"
  systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE
  dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE
  systemctl --user start miraclewm-session.target
} >>/tmp/miracle-session-hook.log 2>&1
