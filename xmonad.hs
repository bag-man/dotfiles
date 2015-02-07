import XMonad
import XMonad.Actions.CycleWS
import XMonad.Layout.NoBorders
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)

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
  ((mod1Mask, xK_w), spawn "firefox"),
  --((mod1Mask, xK_q), spawn "urxvt"),
  ((0, xK_F10), spawn "ncmpcpp toggle"),
  ((0, xK_F9), spawn "ncmpcpp next"),
  ((controlMask .|. mod1Mask, xK_Right), nextWS),
  ((controlMask .|. mod1Mask, xK_Left), prevWS),
  ((mod1Mask .|. shiftMask, xK_Right), shiftToNext >> nextWS),
  ((mod1Mask .|. shiftMask, xK_Left),   shiftToPrev >> prevWS)
 ]

toggleStrutsKey XConfig{modMask = modm} = (modm, xK_b )

myConfig = defaultConfig {
  terminal           = myTerminal,
  borderWidth        = myBorderWidth,
  normalBorderColor  = myBorderColour,
  focusedBorderColor = myBorderColour,
  workspaces         = myWorkspaces,
  layoutHook         = smartBorders $ layoutHook defaultConfig
} `additionalKeys` myKeys
