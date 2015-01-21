# us, fr, us_qwerty-fr, fr bepo
if [[ -n "$1" ]]; then
	setxkbmap $1
else
	setxkbmap fr
fi

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
