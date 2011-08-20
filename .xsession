#!/usr/bin/zsh
 
# Load resources
 
xrdb -load .Xdefaults

# Set up an icon tray
 
trayer --edge top --align right --SetDockType true --SetPartialStrut true  --expand true --width 5 --transparent true --tint 0x073642 --height 12 &
 
# Set the background color
xsetroot -solid black

# Fire up apps
emacs --daemon 

gnome-keyring-daemon

if [ -x /usr/bin/nm-applet ] ; then
   nm-applet --sm-disable &
fi
 
if [ -x /usr/bin/gnome-power-manager ] ; then
   gnome-power-manager &
fi
 
xmonad
