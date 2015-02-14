export LANG=en_US.UTF-8
xset s off -dpms &
setxkbmap -layout gb &  
setxkbmap -option caps:escape &
xsetroot -cursor_name left_ptr &
xmodmap -e "pointer = 1 7 3 4 5 6 2 8 9" &
xmodmap -e "keycode 76 = Insert Insert Insert" &
clipit -n &
nitrogen --restore &  
exec xmonad 
