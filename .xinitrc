#!/usr/bin/fish
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

#setxkbmap -layout gb -option 'ctrl:nocaps'
#English layout, with caps lock as second control

#Colemak English -
setxkbmap -layout gb -variant colemak

xclip &

udiskie &

xset b off

xbindkeys

#emacs as a daemon is now properly managed by systemd

#exec xmonad
exec wmii

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
