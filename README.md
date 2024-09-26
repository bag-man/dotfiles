This is for my Manjaro systems. Install manjaro with the architect, and use cinammon as the DE, and ensure to have yay installed. This gives you a nice platform to bootstrap the rest of the setup from. 

All of the files except for the vim specific stuff (lucius, coc, vimspector) needs to just be moved to the home directory and prepended with a `.` so `xmonad/ -> ~/.xmonad/`, `bashrc -> .bashrc`.

The only exception is the ssh-agent.service file which has commented instructions in. 

Vim will auto install fzf and rg and everything else. It takes two launches to get it all mind. 

Packages used: 

```
bfs-git
brave
copyq
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
trayer
ttf-anonymous-pro
xf86-input-synaptics
xkb-switch
yay
iwd
```

Handy link for installing xmonad: https://brianbuccola.com/how-to-install-xmonad-and-xmobar-via-stack/

Short version, don't use arch repos, build yourself with Stack. 
