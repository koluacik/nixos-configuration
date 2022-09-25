{-# LANGUAGE ScopedTypeVariables #-}

import XMonad
import XMonad.Core (getDirectories)
import XMonad.Operations (restart)
import XMonad.ManageHook
import XMonad.Hooks.DynamicLog (filterOutWsPP, xmobarPP)
import XMonad.Hooks.EwmhDesktops (ewmh, ewmhFullscreen)
import XMonad.Hooks.ManageDocks (ToggleStruts (ToggleStruts), avoidStruts, docks)
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.StatusBar.WorkspaceScreen
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
import Data.List

main :: IO ()
main =
  -- xmonad myXConfig
  getDirectories >>= launch myXConfig

myXConfig =
  docks
    . dynamicSBs (pure . sbOfScreen)
    . ewmhFullscreen
    . ewmh
    $ def
      { terminal = "alacritty",
        layoutHook = myLayoutHook,
        manageHook = namedScratchpadManageHook scratchpads,
        modMask = mod4Mask
      }
      `removeKeys` unwantedKeys
      `additionalKeys` wantedKeys
      `additionalKeysP` mediaKeys

-- Conditionally determines the configuration and executable paths during compile time.
sbOfScreen :: ScreenId -> StatusBarConfig
sbOfScreen (S sid) =
  let
    pp = filterOutWsPP [scratchpadWorkspaceTag] xmobarPP
#ifdef NIXOS_CONFIG_BUILD
    xmobar = XMOBAR_BIN
    configs = [XMOBAR_CONFIG_0, XMOBAR_CONFIG_1]
#else
    xmobar = "xmobar"
    configs = (<>) <*> pure "$HOME/.config/xmobar/xmobarrc_" <$> [0,1]
#endif
  in if sid < 2
  then statusBarPropTo
        ("_XMONAD_LOG_" <> show sid)
        (intercalate " " [xmobar, "-x", show sid, configs !! sid])
        (combineWithScreenName
          (\wsid sName -> wsid <> "(" <> sName <> ")")
          (filterOutWsPP [scratchpadWorkspaceTag] xmobarPP))
  else mempty

unwantedKeys :: [(KeyMask, KeySym)]
unwantedKeys = [ (modMask myXConfig, xK_space)
               , (modMask myXConfig, xK_n)
               , (modMask myXConfig, xK_q)
               ]

wantedKeys =
  [ ((modMask myXConfig, xK_space), sendMessage (Toggle FULL)),
    ((modMask myXConfig .|. shiftMask, xK_space), sendMessage (Toggle NBFULL)),
    ((modMask myXConfig, xK_n), sendMessage (Toggle MIRROR)),
    ((modMask myXConfig, xK_q), restart "xmonad" True),
    ((modMask myXConfig, xK_b), sendMessage (Toggle REFLECTX)),
    ((modMask myXConfig .|. controlMask, xK_Return), namedScratchpadAction scratchpads (show ScratchpadTerminal))
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


data ScratchpadMembers = ScratchpadTerminal
  deriving (Eq, Show, Ord)

scratchpads =
  [ NS
      (show ScratchpadTerminal)
      ("HISTFILE='/home/koluacik/.bash_history_scratchpad' tabbed -fdkn " <> (show ScratchpadTerminal) <> " alacritty --embed")
      (appName =? (show ScratchpadTerminal))
      defaultFloating
 ]

