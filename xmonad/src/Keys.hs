module Keys where

import BaseConfig
import Layout
import Scratchpad
import WindowBringer (windowBringer)
import XMonad
import XMonad.Actions.TiledWindowDragging
import XMonad.Util.EZConfig

modifyKeys :: XConfig l -> XConfig l
modifyKeys config =
  config
    `removeKeys` unwantedKeys
    `additionalKeys` wantedKeys
    `additionalKeysP` mediaKeys
    `additionalMouseBindings` wantedMouseBindings

wantedKeys :: [((KeyMask, KeySym), X ())]
wantedKeys =
  [ ((modMask baseConfig, xK_q), restart "xmonad" True),
    ((modMask baseConfig, xK_space), toggleFull),
    ((modMask baseConfig .|. shiftMask, xK_space), toggleNoBorderFull),
    ((modMask baseConfig, xK_n), toggleMirror),
    ((modMask baseConfig, xK_b), toggleReflectX),
    ((modMask baseConfig .|. controlMask, xK_backslash), windowBringer),
    ((modMask baseConfig .|. controlMask, xK_Return), scratchpadTerminal)
  ]

wantedMouseBindings :: [((ButtonMask, Button), Window -> X ())]
wantedMouseBindings =
  [ ((modMask baseConfig .|. shiftMask, button1), dragWindow)
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

unwantedKeys :: [(KeyMask, KeySym)]
unwantedKeys =
  [ (modMask baseConfig, xK_space),
    (modMask baseConfig, xK_n),
    (modMask baseConfig, xK_q)
  ]