#!/usr/bin/zsh
 
# Load resources
 
xrdb -merge .Xdefaults
xrdb -merge .look-zenburn.xrdb

# Set up an icon tray
 
trayer --edge top --align right --SetDockType true --SetPartialStrut true  --expand true --width 5 --transparent true --tint 0x222222 --height 12 &
 
# Set the background color
xsetroot -solid black

#Set background
qiv -x -t ~/pics/Au_Reve_v2-1280x800.jpg

# Fire up apps
emacs --daemon 

gnome-keyring-daemon

gnome-screensaver & 

if [ -x /usr/bin/nm-applet ] ; then
   nm-applet --sm-disable &
fi
 
if [ -x /usr/bin/gnome-power-manager ] ; then
   sleep 3
   gnome-power-manager &
fi
 
exec ~/.cabal/bin/xmonad
