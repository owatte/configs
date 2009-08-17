#!/bin/bash
 
# Load resources
 
xrdb -merge .Xdefaults
 
# Set up an icon tray
 
trayer --edge top --align right --SetDockType true --SetPartialStrut true  --expand true --width 8 --transparent true --tint 0x000000 --height 12 &
 
# Set the background color
 
xsetroot -solid black

#Set background
qiv -x -t ~/pics/Au_Reve_v2-1280x800.jpg

env EDITOR='emacs'
 
# Fire up apps
 
gnome-screensaver & 

if [ "$PS1" ]; then
    # Disables the bloody CapsLock button
    xmodmap -e "remove lock = Caps_Lock"
fi


if [ -x /usr/bin/nm-applet ] ; then
   nm-applet --sm-disable &
fi
 
if [ -x /usr/bin/gnome-power-manager ] ; then
   sleep 3
   gnome-power-manager
fi
 
exec xmonad
