#!/bin/sh

#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
#

export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
# uim
export GTK_IM_MODULE='uim'
export QT_IM_MODULE='uim'
uim-xim &
export XMODIFIERS='@im=uim'

DEFAULT_SESSION=xfce4-session

feh --bg-scale ~/dotfiles/black-wallpaper-1366x768-027.jpg
while true; do
  DWM_RAM=$(free -m | grep '^Mem' | awk '{print "total: " $2 "MB used: " $3"MB"}')
  DWM_BATTERY=$(acpi -b | awk '{ print $4 $5 }' | sed 's/,/ \/ /g')
  DWM_ESSID=$(iwgetid -r)
  DWM_DATE=$( date +"%F %R" )

  xsetroot -name "RAM $DWM_RAM\
    | Battery: $DWM_BATTERY\
    | WiFi: $DWM_ESSID\
    | $DWM_DATE"
  sleep 1m
done &

exec dwm
