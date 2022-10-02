module Scratchpad (scratchpadTerminal, addScratchpads) where

import XMonad
import XMonad.Util.NamedScratchpad

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
      defaultFloating
  ]
