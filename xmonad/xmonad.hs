import XMonad
import XMonad.Actions.CycleWS
import XMonad.Layout.NoBorders
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.ManageHelpers
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad.Layout.ResizableTile
import XMonad.Actions.CopyWindow

main = xmonad =<< statusBar "xmobar" myPP toggleStrutsKey myConfig

myBorderColour = "#333333"
myBorderWidth  = 2
myWorkspaces   = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
myTerminal     = "st"

myPP = xmobarPP { 
  ppCurrent = (xmobarColor "#117FF5" ""),
  ppTitle = (\str -> ""), 
  ppHidden = (xmobarColor "#626262" ""),
  ppHiddenNoWindows = (xmobarColor "#626262" ""),
  ppLayout = 
    (\x -> case x of
    "ResizableTall" -> "<icon=/home/owg1/.xmonad/icons/tall.xpm/>"
    "Mirror ResizableTall" -> "<icon=/home/owg1/.xmonad/icons/mirror.xpm/>"
    "Full" -> "<icon=/home/owg1/.xmonad/icons/full.xpm/>"
    _ -> x
  )
}

myKeys = [ 

  -- Functions

  ((mod1Mask, xK_F1),spawn "amixer -D pulse set Master 1+ toggle"),
  ((mod1Mask, xK_F2),spawn "amixer -D pulse sset Master 5%-"),
  ((mod1Mask, xK_F3),spawn "amixer -D pulse sset Master 5%+"),
  ((mod1Mask, xK_F4),spawn "mpc prev"),
  ((mod1Mask, xK_F5),spawn "mpc toggle"),
  ((mod1Mask, xK_F6),spawn "mpc next"),
  ((mod1Mask, xK_F7),spawn "brightnessctl s 5%-"),
  ((mod1Mask, xK_F8),spawn "brightnessctl s 5%+"),
  ((mod1Mask, xK_F9),spawn "xkb-switch -n"),

  -- Applications
  ((mod1Mask, xK_w), spawn "brave"),
  ((mod1Mask, xK_p), spawn "rofi -show run"),
  ((mod1Mask, xK_o), spawn "pass clip --rofi"),
  ((mod1Mask, xK_End), spawn "betterlockscreen --lock"),
  ((mod1Mask, xK_v ), windows copyToAll),
  ((controlMask .|. mod1Mask, xK_v ), killAllOtherCopies),
  ((0, xK_F11), spawn "escrotum -s /tmp/shot.png; copyq write image/png - < /tmp/shot.png && copyq select 0"),
  ((controlMask, xK_F11), spawn "escrotum /tmp/shot.png; copyq write image/png - < /tmp/shot.png && copyq select 0"),
  
  -- Media keys (bluetooth headset) /usr/include/X11/XF86keysym.h
  ((0, 0x1008FF17), spawn "mpc next"),
  ((0, 0x1008ff14), spawn "mpc toggle"),
  ((0, 0x1008ff31), spawn "mpc toggle"),
  
  -- Adjust split
  ((mod1Mask, xK_j), sendMessage MirrorShrink),
  ((mod1Mask, xK_k), sendMessage MirrorExpand),
  
  -- Workspaces
  ((controlMask .|. mod1Mask, xK_l), nextWS),
  ((controlMask .|. mod1Mask, xK_h), prevWS),
  ((mod1Mask .|. shiftMask, xK_l), shiftToNext >> nextWS),
  ((mod1Mask .|. shiftMask, xK_h), shiftToPrev >> prevWS),

  -- Master pane count
  ((mod1Mask, xK_apostrophe), sendMessage(IncMasterN(-1))),
  ((mod1Mask, xK_semicolon), sendMessage(IncMasterN(1)))
 ]

toggleStrutsKey XConfig{modMask = modm} = (modm, xK_b )

myManageHook = 
  composeAll[
    isFullscreen --> (doF W.focusDown <+> doFullFloat),
    className =? "mpv" --> doRectFloat (W.RationalRect 0.9 0.84 0.09 0.13) <+> doF copyToAll
  ]

myResizable = smartBorders $ ResizableTall 1 (3/100) (1/2) [] 

myLayout = myResizable ||| Mirror myResizable ||| noBorders Full

startup = do
  spawn "libinput-gestures-setup start &"
  spawn "picom -b --config ~/.picom.conf &"
  spawn "nitrogen --restore &"
  spawn "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand false --width 5 --height 18 --margin 600 --transparent true --alpha 0 --tint 0x111111 --iconspacing 10 &"
  spawn "copyq &"
  spawn "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &"
  spawn "xset -dpms"
  spawn "xset s noblank"
  spawn "xset s off"
  spawn "xset r rate 250 44"
  spawn "setxkbmap  -layout 'gb,se' -option caps:escape"
  spawn "echo SSH_AUTH_SOCK=$SSH_AUTH_SOCK > .ssh-env"
  spawn "sleep 3; xmodmap /home/owg1/.Xmodmap"


myConfig = def {
  terminal           = myTerminal,
  borderWidth        = myBorderWidth,
  normalBorderColor  = myBorderColour,
  focusedBorderColor = myBorderColour,
  workspaces         = myWorkspaces,
  manageHook         = myManageHook,
  startupHook        = startup,
  layoutHook         = myLayout
} `removeKeys` [(mod1Mask, xK_comma), (mod1Mask, xK_period), (mod1Mask, xK_k), (mod1Mask, xK_j)] 
  `additionalKeys` myKeys 
