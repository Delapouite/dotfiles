# Arch Linux Snippets

## Display

### Screen brightness

`$ xbacklight -set 80`

### Multimonitor handling

`$ xrandr --output eDP1 --mode 1920x1080 --output DP2 --mode 1920x1200 --right-of eDP1`

## Virtual Box

### Kernel modules loading

`$ modprobe vboxdrv`
`$ modprobe vboxnetadp`
`$ modprobe vboxnetflt`
