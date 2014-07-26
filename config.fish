set TERM gnome-256color

set -x PRIMUS_UPLOAD 1

set -x EDITOR "emacsclient -c"

set LANG en_GB.UTF-8

alias ocaml='rlwrap ocaml'

alias fishrc='vim ~/.config/fish/config.fish'

alias lt='tree -L 1'

alias lt2='tree -L 2'

alias Syu="sudo pacman -Syu"

alias Ayu="sudo aura -Axyu"

alias Su="sudo pacman -Su"

alias Au="sudo aura -Axu"

alias bat="acpi"

alias countfiles="find . -type f | wc -l"

alias eclipse='knife eclipse -vmargs -Dorg.eclipse.swt.browser.DefaultType=mozilla'

alias define='dict'

alias localip="ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"

alias cal='vim -c :Calendar'

alias pagan='calendar -A 365 -f /usr/share/calendar/calendar.pagan'

alias vmmodules="sudo modprobe -a vboxdrv vboxnetadp vboxnetflt"

alias scrotum='scrot -d 3'

alias xscr='xfce4-screenshooter -r'

alias bham='ssh axh387@tinky-winky.cs.bham.ac.uk'

alias reddit='w3m m.reddit.com/r/askreddit'

alias update-grub='grub-mkconfig -o /boot/grub/grub.cfg'

alias dl-audio="youtube-dl -x --audio-format "mp3" -o '/home/andrew/Music/%(title)s-%(id)s.%(ext)s'"

alias clip="xclip -se c"

alias virtualbox="VirtualBox"
#seriously, who even capitalises executables?

alias lsd="ls | lolcat"

alias screenrec="ffmpeg -f x11grab -s 1920x1080 -i :0.0 -vcodec libvpx -b:v 1M screenrec.webm"

alias clock="tty-clock -ct"

alias proc="ps -A | grep"

alias updatemirrors="sudo reflector --verbose --country 'United Kingdom' -l 200 -p http --sort rate --save /etc/pacman.d/mirrorlist"

alias emc="knife emacsclient -c"

alias emp="emacsclient -e \"(emms-pause)\""

alias ems="emacsclient -e \"(emms-start)\""

alias enext="emacsclient -e \"(emms-next)\""

alias eprev="emacsclient -e \"(emms-previous)\""

alias ecurr="emacsclient -e \"(emms-show)\""

alias emt="emacsclient -t"

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

function search
        aura -Ss $argv
	aura -As $argv
end

# start X at login
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx
    end
end

set fish_greeting ""
