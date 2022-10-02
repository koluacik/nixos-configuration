module StatusBar (addStatusBar) where

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.WorkspaceScreen
import XMonad.Util.NamedScratchpad

addStatusBar :: XConfig l -> XConfig l
addStatusBar = dynamicSBs (pure . sbOfScreen)

sbOfScreen :: ScreenId -> StatusBarConfig
sbOfScreen (S sid) =
  let xmobarBin = "xmobar"
      configs = ("$HOME/.config/xmobar/xmobarrc_" <>) <$> ["0", "1"]
   in if sid < 2
        then
          statusBarPropTo
            ("_XMONAD_LOG_" <> show sid)
            (unwords [xmobarBin, "-x", show sid, configs !! sid])
            ( combineWithScreenName
                (\wsid sName -> wsid <> "(" <> sName <> ")")
                (filterOutWsPP [scratchpadWorkspaceTag] xmobarPP)
            )
        else mempty
