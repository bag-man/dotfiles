export LANG=en_US.UTF-8 
compton --backend glx --vsync opengl &
xset s off -dpms &
xset r rate 250 44 &
setxkbmap -option caps:escape &
xmodmap -e "pointer = 1 7 3 4 5 6 2 8 9" &
xss-lock -- lock -lock &
copyq &
nitrogen --restore &  
trayer --edge top --align right --SetDockType true --SetPartialStrut true  --expand true --width 10 --height 18 --margin 85 --transparent true --alpha 0 --tint 0x111111 &
pamac-tray &
xmodmap ~/.Xmodmap & 
libinput-gestures-setup start &
exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
exec xmonad 
