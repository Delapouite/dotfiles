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

# xmodmap is not directly related to X KeyBoard extension (XKB),
# as it uses different (pre-XKB) ideas on how keycodes are processed within X.

# print-screen as Compose key (aka Multi Language Key)
# xmodmap -e "keysym Print = Multi_key"
# on TMX30 shuffle (102 Muhenkan) and desktop (100 Henkan) keys in 106 mode
xmodmap -e "add mod4 = Super_L Henkan Muhenkan"
# add tap and long press for Caps Lock
xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keysym Caps_Lock = Control_L"
xmodmap -e "add Control = Control_L"
# default to -e "Control_L = Escape"
~/bin/xcape

# switch xmonad bindings with
if [[ `pgrep "xmonad"` ]]; then
	rm ~/.xmonad/xmonad.hs
	case "$1" in
		"bepo") ln -s ~/.xmonad/xmonad.bepo.hs ~/.xmonad/xmonad.hs
		;;

		"lafayette") ln -s ~/.xmonad/xmonad.lafayette.hs ~/.xmonad/xmonad.hs
		;;

		*) ln -s ~/.xmonad/xmonad.azerty.hs ~/.xmonad/xmonad.hs
		;;
	esac
	xmonad --recompile
	xmonad --restart
fi
