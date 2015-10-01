export LANG=en_US.UTF-8 
xset s off -dpms &
xset r rate 250 44 &
xsetroot -cursor_name left_ptr &
xmodmap -e "pointer = 1 7 3 4 5 6 2 8 9" &
xmodmap -e "keycode 76 = Insert Insert Insert" &
clipit -n &
nitrogen --restore &  
trayer --edge top --align right --SetDockType true --SetPartialStrut true  --expand true --width 10 --height 10 --margin 85 --transparent true --alpha 0 --tint 0x111111 &
pamac-tray &
exec xmonad 
