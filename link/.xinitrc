# set cursor
xsetroot -cursor_name left_ptr
# qwerty keyboard, Caps Lock and Print Screen
[ -x ~/bin/kbswitch.sh ] && ~/bin/kbswitch.sh lafayette
# to be parsed by startx, add colors and fonts
[ -f ~/.X/Xresources ] && xrdb -merge ~/.X/Xresources
# [ -f ~/images/wallpapers/current.png ] && feh --bg-scale ~/images/wallpapers/current.png &

exec xmonad
