{-# OPTIONS_GHC -Wno-missing-signatures #-}

module Layout (myLayoutHook, toggleFull, toggleNoBorderFull, toggleMirror, toggleReflectX, addLayoutHook, subLayoutKeys) where

import BaseConfig (baseConfig)
import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Layout.DraggingVisualizer
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders
import XMonad.Layout.Reflect
import XMonad.Layout.Renamed
import XMonad.Layout.SubLayouts
import qualified XMonad.StackSet as W
import XMonad.Layout.BoringWindows

toggleFull, toggleNoBorderFull, toggleMirror, toggleReflectX :: X ()
toggleFull = sendMessage (Toggle FULL)
toggleNoBorderFull = sendMessage (Toggle NBFULL)
toggleMirror = sendMessage (Toggle MIRROR)
toggleReflectX = sendMessage (Toggle REFLECTX)

addLayoutHook config = config {layoutHook = myLayoutHook}

myLayoutHook =
  smartBorders
    . renamed [CutWordsLeft 1]
    -- . windowNavigation
    -- . subTabbed
    -- . boringWindows
    . draggingVisualizer
    . mkToggle1 NBFULL
    . avoidStruts
    . mkToggle (MIRROR ?? FULL ?? EOT)
    . mkToggle1 REFLECTX
    $ Tall 1 (3 / 100) (1 / 2)

subLayoutKeys :: [((KeyMask, KeySym), X ())]
subLayoutKeys =
  [ ((modMask baseConfig .|. controlMask, xK_h), sendMessage $ pullGroup L),
    ((modMask baseConfig .|. controlMask, xK_l), sendMessage $ pullGroup R),
    ((modMask baseConfig .|. controlMask, xK_k), sendMessage $ pullGroup U),
    ((modMask baseConfig .|. controlMask, xK_j), sendMessage $ pullGroup D),
    ((modMask baseConfig .|. controlMask, xK_m), withFocused (sendMessage . MergeAll)),
    ((modMask baseConfig .|. controlMask, xK_u), withFocused (sendMessage . UnMerge)),
    ((modMask baseConfig .|. controlMask, xK_period), onGroup W.focusDown'),
    ((modMask baseConfig .|. controlMask, xK_comma), onGroup W.focusUp'),
    ((modMask baseConfig, xK_k), focusUp),
    ((modMask baseConfig, xK_j), focusDown),
    ((modMask baseConfig, xK_m), focusMaster)
  ]