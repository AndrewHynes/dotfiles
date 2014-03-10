set TERM gnome-256color

set EDITOR vim

set LANG en_GB.UTF-8

#set PANEL_FIFO /tmp/panel-fifo

#set PANEL_HEIGHT 24

alias ocaml='rlwrap ocaml'

alias fishrc='vim ~/.config/fish/config.fish'

alias lt='tree -L 1'

alias lt2='tree -L 2'

alias bat="acpi"

alias eclipse='eclipse -vmargs -Dorg.eclipse.swt.browser.DefaultType=mozilla'

alias define='dict'

alias cal='vim -c :Calendar'

alias pagan='calendar -A 365 -f /usr/share/calendar/calendar.pagan'

#eval 'opam config env'

alias scrotum='scrot -d 3'

alias xscr='xfce4-screenshooter -r'

alias reddit='w3m m.reddit.com/r/askreddit'

alias update-grub='grub-mkconfig -o /boot/grub/grub.cfg'

alias dl-audio="youtube-dl -x --audio-format "mp3" -o '/home/andrew/Music/%(title)s-%(id)s.%(ext)s'"


set PATH ~/.cabal/bin $PATH

function fish_title
	echo 'Terminal-chan'
end

function !!
    eval sudo $history[1]
end

function removewhitespace
	cp ~/Documents/OCaml/mvfiles/mvfiles .
	./mvfiles
	rm mvfiles
end

set fish_greeting ""

clear

fortune -a
