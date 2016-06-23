These are the dotfiles for my various systems running XMonad & Parabola / Arch / Manjaro. 

The idea behind my setup is to unify the UI on the HJKL keys. Once you get used to it you really feel the slow down when you reach for the mouse. 

If you use Vim heavily, and add Vimium / VimFX to your Chrome / Firefox, then using the Xmonad mappings enable you to work pretty much just from the home row. 

My `~/.vimrc` is focussed on being able to be (for the most part) standalone and auto installing. This means that when you work on a new host all that is needed to do to replicate my local setup is to curl the vimrc to my home directory and launch Vim. 

To make this a bit easier I have a cron job that pulls down the latest version from github and hosts it on my server. This means I can just do `curl owen.cyrmu/vimrc > ~/.vimrc` and launch Vim to get my up to date configurations and plugins.
