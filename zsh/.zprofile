if (systemctl -q &>/dev/null);
		then
		systemctl --user import-environment PATH DBUS_SESSION_BUS_ADDRESS
		systemctl --no-block --user start xsession.target
fi
stty -ixon

[[ -z $DISPLAY && $XDG_VTNR -eq 2 ]] && exec startx
