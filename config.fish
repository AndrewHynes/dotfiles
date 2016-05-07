set TERM gnome-256color

set -x PRIMUS_UPLOAD 1

set -x EDITOR "emacsclient -c"

set -x JAVA_HOME "/usr/lib/jvm/default"

set LANG en_GB.UTF-8

alias worm='knife okular ~/Downloads/WildbowScrape/worm.pdf'

alias pact='knife okular ~/Downloads/WildbowScrape/pact.pdf'

alias twig='knife okular ~/Downloads/WildbowScrape/twig.pdf'

alias fixSteam='find ~/.steam/root/ -name "libgpg-error.so*" -print -delete'

alias fixSteamAlt='rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/amd64/installed/libstdc++6-4.6-pic_4.6.3-1ubuntu5+srt4_amd64
rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/amd64/installed/libstdc++6-4.6-pic_4.6.3-1ubuntu5+srt4_amd64.md5
rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/amd64/installed/libstdc++6_4.8.1-2ubuntu1~12.04+steamrt2+srt1_amd64
rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/amd64/installed/libstdc++6_4.8.1-2ubuntu1~12.04+steamrt2+srt1_amd64.md5
rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/amd64/usr/lib/gcc/x86_64-linux-gnu/4.6/libstdc++_pic.a
rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/amd64/usr/lib/gcc/x86_64-linux-gnu/4.6/libstdc++_pic.map
rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/amd64/usr/lib/x86_64-linux-gnu/libstdc++.so.6 rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/amd64/usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.18
rm  ~/.local/share/Steam/ubuntu12_32/steam-runtime/amd64/usr/share/doc/libstdc++6
rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/amd64/usr/share/doc/libstdc++6-4.6-pic
rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/i386/installed/libstdc++6-4.6-pic_4.6.3-1ubuntu5+srt4_i386
rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/i386/installed/libstdc++6-4.6-pic_4.6.3-1ubuntu5+srt4_i386.md5
rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/i386/installed/libstdc++6_4.8.1-2ubuntu1~12.04+steamrt2+srt1_i386
rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/i386/installed/libstdc++6_4.8.1-2ubuntu1~12.04+steamrt2+srt1_i386.md5
rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/i386/usr/lib/gcc/i686-linux-gnu/4.6/libstdc++_pic.a
rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/i386/usr/lib/gcc/i686-linux-gnu/4.6/libstdc++_pic.map
rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/i386/usr/lib/i386-linux-gnu/libstdc++.so.6
rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/i386/usr/lib/i386-linux-gnu/libstdc++.so.6.0.18
rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/i386/usr/share/doc/libstdc++6
rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/i386/usr/share/doc/libstdc++6-4.6-pic
rm ~/.local/share/Steam/ubuntu12_32/steam-runtime.old/i386/usr/share/doc/libstdc++6 &&
rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/amd64/lib/x86_64-linux-gnu/libgcc_s.so.1
rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/i386/lib/i386-linux-gnu/libgcc_s.so.1
rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/i386/usr/lib/i386-linux-gnu/libxcb.so.1'

alias ocaml='rlwrap ocaml'

alias fishrc='emc ~/.config/fish/config.fish'

alias lt='tree -L 1'

alias lt2='tree -L 2'

alias Syu="sudo pacman -Syu"

alias Ayu="sudo aura -Axyu"

alias Su="sudo pacman -Su"

alias Au="sudo aura -Axu"

alias -="cd -"

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

alias e="emc"

alias emp="emacsclient -e \"(emms-pause)\""

alias ems="emacsclient -e \"(emms-start)\""

alias enext="emacsclient -e \"(emms-next)\""

alias eprev="emacsclient -e \"(emms-previous)\""

alias ecurr="emacsclient -e \"(emms-show)\""

alias emt="emacsclient -t"

set PATH ~/.cabal/bin $PATH
set PATH  /opt/clojurescript/bin/ $PATH

#OPAM setup
set PATH /home/andrew/.opam/system/bin $PATH
set OCAML_TOPLEVEL_PATH "/home/andrew/.opam/system/lib/toplevel"
set PERL5LIB "/home/andrew/.opam/system/lib/perl5:$PERL5LIB"
set MANPATH "$MANPATH" "/home/andrew/.opam/system/man"
set CAML_LD_LIBRARY_PATH "/home/andrew/.opam/system/lib/stublibs:/usr/lib/ocaml/stublibs"

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

set fish_greeting ""

# start X at login
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx
    end
end

