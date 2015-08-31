# us, fr, us_qwerty-fr, fr bepo, lafayette
case "$1" in
	"bepo") setxkbmap fr bepo
	;;

	"lafayette") xkbcomp -w0 ~/bin/lafayette.xkb $DISPLAY
	;;

	*) setxkbmap $1
	;;
esac

# using the above command unfortunately reset custom xmodmap bindings
# hence the need to set them again

# print screen as another super for xmonad
xmodmap -e "add mod4 = Super_L Print"
# add tap and long press for Caps Lock
xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keysym Caps_Lock = Control_L"
xmodmap -e "add Control = Control_L"
# default to -e "Control_L = Escape"
~/bin/xcape

# switch xmonad bindings with
if [[ `pgrep "xmonad"` ]]; then
	rm ~/.xmonad/xmonad.hs
	if [[ "$1" == 'bepo' ]]; then
		ln -s ~/.xmonad/xmonad.bepo.hs ~/.xmonad/xmonad.hs
	else
		ln -s ~/.xmonad/xmonad.azerty.hs ~/.xmonad/xmonad.hs
	fi
	xmonad --recompile
	xmonad --restart
fi
