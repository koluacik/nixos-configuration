import XMonad
import XMonad.Hooks.DynamicBars (dynStatusBarStartup, multiPP)
import XMonad.Hooks.DynamicLog (filterOutWsPP, xmobarPP)
import XMonad.Hooks.EwmhDesktops (ewmh, ewmhFullscreen)
import XMonad.Hooks.ManageDocks (ToggleStruts (ToggleStruts), avoidStruts, docks)
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders
  ( Ambiguity (OnlyScreenFloat),
    lessBorders,
    smartBorders,
  )
import XMonad.Layout.Reflect (REFLECTX (REFLECTX), reflectHoriz)
import XMonad.StackSet
import XMonad.Util.EZConfig (additionalKeys, additionalKeysP, removeKeys)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.Scratchpad

main :: IO ()
main =
  xmonad myXConfig

myXConfig =
  docks
    . ewmhFullscreen
    . ewmh
    $ def
      { terminal = "alacritty",
        startupHook = myStartupHook,
        layoutHook = myLayoutHook,
        logHook = myBarsPP,
        manageHook = scratchpadManageHook (RationalRect (679 / 1920) (359 / 1080) (562 / 1920) (362 / 1080)),
        modMask = mod4Mask
      }
      `removeKeys` unwantedKeys
      `additionalKeys` wantedKeys
      `additionalKeysP` mediaKeys

myStartupHook :: X ()
myStartupHook = dynStatusBarStartup startBar killBars
  where
    startBar (S id') = spawnPipe $ "xmobar -x " ++ show id'
    killBars = return ()

myBarsPP :: X ()
myBarsPP = multiPP focusedPP unfocusedPP
  where
    focusedPP = filterOutWsPP [scratchpadWorkspaceTag] xmobarPP
    unfocusedPP = focusedPP

unwantedKeys :: [(KeyMask, KeySym)]
unwantedKeys = [(modMask myXConfig, xK_space), (modMask myXConfig, xK_n)]

wantedKeys =
  [ ((modMask myXConfig, xK_space), sendMessage (Toggle FULL)),
    ((modMask myXConfig .|. shiftMask, xK_space), sendMessage (Toggle NBFULL)),
    ((modMask myXConfig, xK_n), sendMessage (Toggle MIRROR)),
    ((modMask myXConfig, xK_b), sendMessage (Toggle REFLECTX)),
    ((modMask myXConfig .|. controlMask, xK_Return), scratchpadSpawnActionCustom "HISTFILE='/home/koluacik/.bash_history_scratchpad' tabbed -fdkn scratchpad alacritty --embed")
  ]

mediaKeys :: [(String, X ())]
mediaKeys =
  [ ("<XF86AudioPlay>", spawn "playerctl play-pause"),
    ("<XF86AudioPrev>", spawn "playerctl previous"),
    ("<XF86AudioNext>", spawn "playerctl next"),
    ("<XF86AudioRaiseVolume>", spawn "amixer sset Master 5%+"),
    ("<XF86AudioLowerVolume>", spawn "amixer sset Master 5%-"),
    ("<XF86MonBrightnessUp>", spawn "brightnessctl s +10%"),
    ("<XF86MonBrightnessDown>", spawn "brightnessctl s 10%-")
  ]

myLayoutHook =
  smartBorders . mkToggle1 NBFULL . avoidStruts
    . mkToggle (MIRROR ?? FULL ?? EOT)
    . mkToggle1 REFLECTX
    $ Tall 1 (3 / 100) (1 / 2)

doFullscreen :: X ()
doFullscreen = sendMessage (Toggle NBFULL)
