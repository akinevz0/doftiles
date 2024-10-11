if (systemctl -q &>/dev/null); then
  if [[ $(grep -i Microsoft /proc/version ) ]]; then
    stty -ixon
  else
    systemctl --user import-environment PATH DBUS_SESSION_BUS_ADDRESS
    systemctl --no-block --user start xsession.target
    [[ -z $DISPLAY && $XDG_VTNR -eq 2 ]] && exec startx
  fi
fi
