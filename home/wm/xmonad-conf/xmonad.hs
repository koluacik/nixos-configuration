import XMonad
import XMonad.Hooks.DynamicBars
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops (ewmh, ewmhFullscreen)
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig (additionalKeys, additionalKeysP)

main :: IO ()
main = xmonad
    . docks
    . ewmhFullscreen
    . ewmh
    $ def
        { terminal = "alacritty"
        , startupHook = myStartupHook
        , layoutHook = avoidStruts (layoutHook def)
        , logHook = myBarsPP
        , modMask = mod4Mask
        }
    `additionalKeysP` mediaKeys

myStartupHook = dynStatusBarStartup startBar killBars
  where startBar (S id') = spawnPipe $ "xmobar -x " ++ show id'
        killBars = return ()

myBarsPP = multiPP focusedPP unfocusedPP
  where
    focusedPP = xmobarPP
    unfocusedPP = focusedPP

mediaKeys =
    [ ("<XF86AudioPlay>"        , spawn "playerctl play-pause")
    , ("<XF86AudioPrev>"        , spawn "playerctl previous")
    , ("<XF86AudioNext>"        , spawn "playerctl next")
    , ("<XF86AudioRaiseVolume>" , spawn "amixer -D pulse sset Master 5%+")
    , ("<XF86AudioLowerVolume>" , spawn "amixer -D pulse sset Master 5%-")
    , ("<XF86MonBrightnessUp>"  , spawn "brightnessctl s +10%")
    , ("<XF86MonBrightnessDown>", spawn "brightnessctl s 10%-")
    ]
