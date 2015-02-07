import XMonad
import XMonad.Actions.CycleWS
import XMonad.Layout.NoBorders
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.ManageHelpers
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig

main = xmonad =<< statusBar "xmobar" myPP toggleStrutsKey myConfig

myBorderColour = "#333333"
myBorderWidth  = 2
myWorkspaces   = ["I", "II", "III", "IV", "V"]
myTerminal     = "urxvt"

myPP = xmobarPP { 
  ppCurrent = xmobarColor "#888888" "",
  ppTitle = (\str -> ""), 
  ppLayout = (\str -> ""),
  ppHidden = (xmobarColor "#626262" ""),
  ppHiddenNoWindows = (xmobarColor "#626262" "")
}

myKeys = [ 
  ((mod4Mask, xK_w), spawn "firefox"),
  ((mod4Mask, xK_q), spawn "urxvt"),
  ((0, xK_F9), spawn "ncmpcpp next"),
  ((0, xK_F10), spawn "ncmpcpp toggle"),
  ((0, xK_F11),spawn "amixer set Master 5-"),
  ((0, xK_F12),spawn "amixer set Master 5+"),
  ((mod1Mask, xK_F4), kill),
  ((controlMask .|. mod1Mask, xK_Right), nextWS),
  ((controlMask .|. mod1Mask, xK_Left), prevWS),
  ((mod1Mask .|. shiftMask, xK_Right), shiftToNext >> nextWS),
  ((mod1Mask .|. shiftMask, xK_Left), shiftToPrev >> prevWS),
  ((mod1Mask .|. shiftMask, xK_period), sendMessage(IncMasterN(-1))) -- Shift+Alt+. 
 ]

toggleStrutsKey XConfig{modMask = modm} = (modm, xK_b )

myManageHook = composeAll[isFullscreen --> (doF W.focusDown <+> doFullFloat)]

myConfig = defaultConfig {
  terminal           = myTerminal,
  borderWidth        = myBorderWidth,
  normalBorderColor  = myBorderColour,
  focusedBorderColor = myBorderColour,
  workspaces         = myWorkspaces,
  manageHook         = myManageHook,
  layoutHook         = smartBorders $ layoutHook defaultConfig
} `removeKeys` [(mod1Mask, xK_period)] -- Removes Alt+.
  `additionalKeys` myKeys 
