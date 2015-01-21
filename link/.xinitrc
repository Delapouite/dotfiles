# set cursor
xsetroot -cursor_name left_ptr
# french keyboard, Caps Lock and Print Screen
[ -x ~/bin/kbswitch.sh ] && ~/bin/kbswitch.sh fr
# to be parsed by startx, add colors and fonts
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
# [ -f ~/images/wallpapers/current.png ] && feh --bg-scale ~/images/wallpapers/current.png &

exec xmonad
