module Scratchpad (scratchpadTerminal, addScratchpads) where

import XMonad
import XMonad.Util.NamedScratchpad
import XMonad.StackSet

scratchpadTerminal :: X ()
scratchpadTerminal = namedScratchpadAction scratchpads (show ScratchpadTerminal)

data ScratchpadMembers = ScratchpadTerminal
  deriving (Eq, Show, Ord)

addScratchpads :: XConfig l -> XConfig l
addScratchpads config@(XConfig {manageHook}) = config {manageHook = idHook <+> manageHook}

scratchpads :: [NamedScratchpad]
scratchpads =
  [ NS
      (show ScratchpadTerminal)
      ("HISTFILE=\"$HOME/.bash_history_scratchpad\" tabbed -fdkn " <> show ScratchpadTerminal <> " alacritty --embed")
      (appName =? show ScratchpadTerminal)
      (customFloating (RationalRect (1/3) (1/3) (1/3) (1/3)))
  ]
