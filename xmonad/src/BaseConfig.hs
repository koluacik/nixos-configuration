module BaseConfig (baseConfig) where

import XMonad

baseConfig :: XConfig (Choose Tall (Choose (Mirror Tall) Full))
baseConfig =
  def
    { terminal = "alacritty",
      modMask = mod4Mask
    }
