if (systemctl -q &>/dev/null);
		then
		systemctl --user import-environment PATH DBUS_SESSION_BUS_ADDRESS
		systemctl --no-block --user start xsession.target
fi
stty -ixon

export EDITOR=vim
export LOCAL_BIN=$HOME/.local/bin
export JDK_HOME="/usr/lib/jvm/default/"
export PATH=$LOCAL_BIN:$PATH:$JDK_HOME/bin

[[ -z $DISPLAY && $XDG_VTNR -eq 2 ]] && exec startx
