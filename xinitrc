export LANG=en_US.UTF-8 
xset s off -dpms &
xset r rate 250 44 &
setxkbmap -layout gb &
setxkbmap -option caps:escape &
xsetroot -cursor_name left_ptr &
xmodmap -e "pointer = 1 7 3 4 5 6 2 8 9" &
xmodmap -e "keycode 76 = Insert Insert Insert" &
xmodmap -e "keycode 75 = F9 F9 F9" &
xmodmap -e "keycode 74 = F8 F8 F8" &
xmodmap -e "keycode 133 = Escape"&
clipit -n &
nitrogen --restore &  
exec xmonad 
