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

setxkbmap -layout gb &

xclip &

xmodmap -e "keycode 104 = Return" &

xbindkeys

emacs --daemon &

#exec xmonad
exec wmii

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
