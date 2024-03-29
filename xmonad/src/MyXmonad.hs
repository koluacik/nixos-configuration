module MyXmonad where

import BaseConfig (baseConfig)
import Keys (modifyKeys)
import StatusBar (addStatusBar)
import XMonad (xmonad)
import XMonad.Hooks.EwmhDesktops (ewmh, ewmhFullscreen)
import XMonad.Hooks.ManageDocks (docks)
import Layout (addLayoutHook)
import Scratchpad (addScratchpads)
import Reparenter (debugHandleEvent)

main :: IO ()
main =
  xmonad
    -- . debugHandleEvent
    . docks
    . addStatusBar
    . ewmhFullscreen
    . ewmh
    . modifyKeys
    . addScratchpads
    . addLayoutHook
    $ baseConfig
