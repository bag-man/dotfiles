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
  ppCurrent = xmobarColor "#888888" "",
  ppTitle = (\str -> ""), 
  ppLayout = (\str -> ""),
  ppHidden = (xmobarColor "#626262" ""),
  ppHiddenNoWindows = (xmobarColor "#626262" "")
}

myKeys = [ 
  -- Chromebook
  ((mod1Mask, xK_w), spawn "firefox"),
  ((mod1Mask, xK_q), spawn "urxvt"),
  ((0, xK_F6), spawn "xbacklight -dec 10"),
  ((0, xK_F7), spawn "xbacklight -inc 10"),
  ((0, xK_F9), spawn "touchtoggle"),
  ((0, xK_Super_L), spawn "dmenu_run"),

  -- Desktop
  ((mod4Mask, xK_w), spawn "firefox"),
  ((mod4Mask, xK_q), spawn "urxvt"),
  ((0, xK_F9), spawn "ncmpcpp next"),
  ((0, xK_F10), spawn "ncmpcpp toggle"),
  ((0, xK_F11),spawn "amixer set Master 5-"),
  ((0, xK_F12),spawn "amixer set Master 5+"),
  ((mod1Mask, xK_F4), kill),
  ((mod1Mask, xK_End), spawn "shutdown -h now"),
  
  -- Adjust split
  ((mod1Mask, xK_j), sendMessage MirrorShrink),
  ((mod1Mask, xK_k), sendMessage MirrorExpand),
  
  -- Workspaces
  ((controlMask .|. mod1Mask, xK_Right), nextWS),
  ((controlMask .|. mod1Mask, xK_Left), prevWS),
  ((mod1Mask .|. shiftMask, xK_Right), shiftToNext >> nextWS),
  ((mod1Mask .|. shiftMask, xK_Left), shiftToPrev >> prevWS),
  ((mod1Mask .|. shiftMask, xK_period), sendMessage(IncMasterN(-1))) -- Shift+Alt+. 
 ]

toggleStrutsKey XConfig{modMask = modm} = (modm, xK_b )

myManageHook = composeAll[isFullscreen --> (doF W.focusDown <+> doFullFloat)]
myLayout = smartBorders $ ResizableTall 1 (3/100) (1/2) [] ||| layoutHook defaultConfig

myConfig = defaultConfig {
  terminal           = myTerminal,
  borderWidth        = myBorderWidth,
  normalBorderColor  = myBorderColour,
  focusedBorderColor = myBorderColour,
  workspaces         = myWorkspaces,
  manageHook         = myManageHook,
  layoutHook         = myLayout
} `removeKeys` [(mod1Mask, xK_period), (mod1Mask, xK_k), (mod1Mask, xK_j)] -- Removes Alt+. Alt+j Alt+k
  `additionalKeys` myKeys 
