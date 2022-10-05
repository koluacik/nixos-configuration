{-# OPTIONS_GHC -Wno-missing-signatures #-}

module Layout (myLayoutHook, toggleFull, toggleNoBorderFull, toggleMirror, toggleReflectX, addLayoutHook) where

import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders
import XMonad.Layout.Reflect
import XMonad.Layout.DraggingVisualizer
import XMonad.Layout.Renamed

toggleFull, toggleNoBorderFull, toggleMirror, toggleReflectX :: X ()
toggleFull = sendMessage (Toggle FULL)
toggleNoBorderFull = sendMessage (Toggle NBFULL)
toggleMirror = sendMessage (Toggle MIRROR)
toggleReflectX = sendMessage (Toggle REFLECTX)

addLayoutHook config = config {layoutHook = myLayoutHook}

myLayoutHook =
  smartBorders
    . renamed [CutWordsLeft 1] -- Remove DraggingVisualizer from the layout description
    . draggingVisualizer
    . mkToggle1 NBFULL
    . avoidStruts
    . mkToggle (MIRROR ?? FULL ?? EOT)
    . mkToggle1 REFLECTX
    $ Tall 1 (3 / 100) (1 / 2)
