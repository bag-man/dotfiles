import XMonad
import XMonad.Actions.CycleWS
import XMonad.Layout.NoBorders
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.ManageHelpers
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad.Layout.ResizableTile

main = xmonad =<< statusBar "xmobar" myPP toggleStrutsKey myConfig

myBorderColour = "#333333"
myBorderWidth  = 2
myWorkspaces   = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
myTerminal     = "urxvt"

myPP = xmobarPP { 
  ppCurrent = (xmobarColor "#117FF5" "" . const "•"),
  ppTitle = (\str -> ""), 
  ppHidden = (xmobarColor "#626262" "" . const "•"),
  ppHiddenNoWindows = (xmobarColor "#626262" "" . const "•"),
  ppLayout = 
    (\x -> case x of
    "ResizableTall" -> "<icon=/home/oweng/.xmonad/icons/tall.xpm/>"
    "Mirror ResizableTall" -> "<icon=/home/oweng/.xmonad/icons/mirror.xpm/>"
    "Full" -> "<icon=/home/oweng/.xmonad/icons/full.xpm/>"
    _ -> x
  )
}

myKeys = [ 
  -- Chromebook
  ((0, xK_F6), spawn "xbacklight -dec 10"),
  ((0, xK_F7), spawn "xbacklight -inc 10"),
  ((0, xK_Super_L), spawn "dmenu_run"),

  -- Audio
  ((0, xK_F9), spawn "mpc next"),
  ((0, xK_F10), spawn "mpc toggle"),
  ((0, xK_F11),spawn "amixer set Master 5-"),
  ((0, xK_F12),spawn "amixer set Master 5+"),

  -- Applications
  ((mod1Mask, xK_w), spawn "google-chrome-stable"),
  ((mod1Mask, xK_F4), kill),
  ((mod1Mask, xK_End), spawn "vlock -ans"),
  ((0, xK_Print), spawn "sleep 0.2; scrot -s /tmp/shot.png; copyq write image/png - < /tmp/shot.png && copyq select 0"),
  
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

myManageHook = composeAll[isFullscreen --> (doF W.focusDown <+> doFullFloat)]

myResizable = smartBorders $ ResizableTall 1 (3/100) (1/2) [] 

myLayout = myResizable ||| Mirror myResizable ||| Full

myConfig = defaultConfig {
  terminal           = myTerminal,
  borderWidth        = myBorderWidth,
  normalBorderColor  = myBorderColour,
  focusedBorderColor = myBorderColour,
  workspaces         = myWorkspaces,
  manageHook         = myManageHook,
  layoutHook         = myLayout
} `removeKeys` [(mod1Mask, xK_comma), (mod1Mask, xK_period), (mod1Mask, xK_k), (mod1Mask, xK_j)] 
  `additionalKeys` myKeys 
