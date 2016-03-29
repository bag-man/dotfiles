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
  ppHidden = (xmobarColor "#626262" ""),
  ppHiddenNoWindows = (xmobarColor "#626262" ""),
  ppLayout = 
    (\x -> case x of
    "ResizableTall" -> "<icon=/home/oweng/.xmonad/icons/tall.xpm/>"
    "Mirror ResizableTall" -> "<icon=/home/oweng/.xmonad/icons/mirror.xpm/>"
    "Full" -> "<icon=/home/oweng/.xmonad/icons/full.xpm/>"
    _ -> x
  )
}

myKeys = [ 
  ((mod1Mask, xK_w), spawn "firefox"),
  ((mod1Mask, xK_F4), kill),
  ((mod1Mask, xK_End), spawn "shutdown -h now"),
  ((mod1Mask .|. controlMask, xK_End), spawn "dm-tool lock"),
  ((0, xK_Print), spawn "sleep 0.2; scrot -s /tmp/shot.png; copyq write image/png - < /tmp/shot.png && copyq select 0"),
  
  -- Adjust split
  ((mod1Mask, xK_j), sendMessage MirrorShrink),
  ((mod1Mask, xK_k), sendMessage MirrorExpand),
  
  -- Workspaces
  ((controlMask .|. mod1Mask, xK_l), nextWS),
  ((controlMask .|. mod1Mask, xK_h), prevWS),
  ((mod1Mask .|. shiftMask, xK_l), shiftToNext >> nextWS),
  ((mod1Mask .|. shiftMask, xK_h), shiftToPrev >> prevWS),
  ((mod1Mask .|. shiftMask, xK_period), sendMessage(IncMasterN(-1))) -- Shift+Alt+. 
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
} `removeKeys` [(mod1Mask, xK_period), (mod1Mask, xK_k), (mod1Mask, xK_j)] -- Removes Alt+. Alt+j Alt+k
  `additionalKeys` myKeys 
