This is for my Manjaro systems. Install manjaro with the architect, and use cinammon as the DE, and ensure to have yay installed. This gives you a nice platform to bootstrap the rest of the setup from. 

All of the files except for the vim specific stuff (lucious, coc, vimspector) needs to just be moved to the home directory and prepended with a `.`.  i.e. `xmonad/ -> `~/.xmonad/`, `bashrc -> .bashrc`.

The only exception is the ssh-agent.service file which has commented instructions in. 

Vim will auto install fzf and rg and everything else. It takes two launches to get it all mind. 

Packages used: 

```
bfs-git
brave
copyq
docker-compose
gvim
htop
icdiff
libinput-gestures
nitrogen
openssh
pamac-gtk
pass
pass-clip
pkgfile
rofi
scrot
trayer
ttf-anonymous-pro
wifi-menu
xf86-input-synaptics
xkb-switch
xmobar
xmonad
xmonad-contrib
yay
```
