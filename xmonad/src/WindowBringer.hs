module WindowBringer (windowBringer) where

import XMonad
import XMonad.Actions.WindowBringer
import XMonad.Hooks.DynamicLog (wrap)
import XMonad.StackSet (tag)
import XMonad.Util.NamedWindows (getName)

windowBringer :: X ()
windowBringer = gotoMenuConfig windowBringerConfig

windowBringerConfig :: WindowBringerConfig
windowBringerConfig =
  def
    { menuArgs = ["-i", "-l", "10"],
      windowTitler = decorateName'
    }

decorateName' :: WindowSpace -> Window -> X String
decorateName' ws w = do
  name <- show <$> getName w
  pure $ unwords [wrap "[" "]" (tag ws), name]
