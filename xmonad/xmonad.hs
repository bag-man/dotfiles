import XMonad
import XMonad.Actions.CycleWS
import XMonad.Layout.NoBorders
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.ManageHelpers
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad.Layout.ResizableTile
import XMonad.Util.NamedScratchpad

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

myScratchPads :: [NamedScratchpad]
myScratchPads =
    [ NS "peek" "peek" (appName =? "peek" ) $ customFloating peek
    , NS "st" "st -T peek" (title =? "peek" ) $ customFloating st
    ]
    where
        peek = W.RationalRect (1/6) (1/6) (2/3) (2/3)
        st = W.RationalRect ((1/6)+0.004) ((1/6)+0.05) ((2/3)-0.007) ((2/3)-0.057) 

myKeys = [ 

  -- Functions
  ((mod1Mask, xK_Up), spawn "xbacklight -inc 5"),
  ((mod1Mask, xK_Down), spawn "xbacklight -dec 5"),
  ((0, xK_F9),spawn "lollypop -n"),
  ((0, xK_Pause),spawn "lollypop -t"),
  ((0, xK_F10),spawn "lollypop -t"),
  ((0, xK_F11),spawn "amixer -D pulse sset Master 5%-"),
  ((0, xK_Insert),spawn "amixer -D pulse sset Master 5%+"),

  -- Applications
  ((mod1Mask, xK_w), spawn "google-chrome-stable"),
  ((mod1Mask, xK_F4), kill),
  ((mod1Mask, xK_F5), spawn "peek -t"),
  ((mod1Mask, xK_F7), sequence_ [namedScratchpadAction myScratchPads "peek", namedScratchpadAction myScratchPads "st"]),


  ((mod1Mask, xK_i), spawn "rofi-copyq"),
  ((mod1Mask, xK_p), spawn "rofi -show run"),
  ((mod1Mask, xK_o), spawn "pass clip --rofi"),
  ((mod1Mask, xK_End), spawn "slock"),
  ((0, xK_Print), spawn "sleep 0.2; scrot -o -q 100 -s /tmp/shot.png; copyq write image/png - < /tmp/shot.png && copyq select 0"),
  ((controlMask, xK_Print), spawn "scrot -o -q 100 /tmp/shot.png; copyq write image/png - < /tmp/shot.png && copyq select 0"),
  
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

myManageHook = composeAll . concat $
  [
    [isFullscreen --> (doF W.focusDown <+> doFullFloat)],
    [namedScratchpadManageHook myScratchPads],
  ]

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
