{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Redundant bracket" #-}
module Reparenter where

import Control.Monad
import Data.List (isSuffixOf)
import System.IO
import XMonad
import XMonad.Actions.WindowBringer (windowMap)
import XMonad.Layout.DraggingVisualizer
import XMonad.Util.Dmenu (dmenu)
import XMonad.StackSet
import GHC.IO.Handle.Types (Handle__)
import Control.Concurrent (threadDelay)
import Data.Monoid (All)
import Data.Semigroup
import XMonad.Hooks.DebugEvents

createTabber :: X ()
createTabber = createTabberWithPrefix mempty

tabberWmClass :: String
tabberWmClass = "TABBER"

createTabberWithPrefix :: String -> X ()
createTabberWithPrefix prefix = spawn $ "tabbed -dkn " <> prefix <> tabberWmClass

createTabberWithPrefixDmenu :: X ()
createTabberWithPrefixDmenu = do
  prefix <- dmenu mempty
  unless (null prefix) (createTabberWithPrefix $ prefix <> " ")

query :: X ()
query = do
  withDisplay $ \disp ->
    withFocused $ \win -> io (queryTree disp win) >>= dumpToFile . show

reparentDrag :: Window -> X ()
reparentDrag window = do
  winIsTabber <- isTabber window
  if winIsTabber
    then reparentOutOfTabbedDrag window -- Drag child out to the root window
    else reparentIntoTabbedDrag window -- reparent into the tabber window

reparentIntoTabbedDrag :: Window -> X ()
reparentIntoTabbedDrag window =
  visualizedMouseDrag
    window
    ( do
        maybeTargetWindow <- getWindowUnderCursor
        case maybeTargetWindow of
          Nothing ->
            mempty
          Just targetWindow ->
            whenX
              (isTabber targetWindow)
              (reparentWindow' window targetWindow)
    )

reparentOutOfTabbedDrag :: Window -> X ()
reparentOutOfTabbedDrag window = do
  maybeLastChildWindow <- getLastChild window
  case maybeLastChildWindow of
    Nothing ->
      mempty
    Just focusedChild -> withDisplay $ \dpy -> do
      root <- asks theRoot
      reparentWindow' focusedChild root
      io $ mapWindow dpy focusedChild

      mouseMoveWindow focusedChild
      maybeTargetWindow <- getWindowUnderCursor
      case maybeTargetWindow of
        Nothing ->
          mempty
        Just targetWindow -> do
          windowIsTabber <- isTabber targetWindow
          if windowIsTabber
            then reparentWindow' focusedChild targetWindow
            else withFocused $ windows . sink

{-  visualizedMouseDrag
   focusedChild
   ( do
       root <- asks theRoot
       maybeTargetWindow <- getWindowUnderCursor
       case maybeTargetWindow of
         Nothing ->
           reparentWindow' focusedChild root
         Just targetWindow -> do
           windowIsTabber <- isTabber targetWindow
           if windowIsTabber
             then reparentWindow' focusedChild targetWindow
             else reparentWindow' focusedChild root
   ) -}

reparentWindow' :: Window -> Window -> X ()
reparentWindow' src parent =
  withDisplay $ \dpy -> io $ do
    reparentWindow dpy src parent 0 0


dumpToFile :: String -> X ()
dumpToFile val = io (withFile "/home/koluacik/.xmonad_err" WriteMode (`hPutStrLn` val))

dumpToFile' :: String -> String -> X ()
dumpToFile' filename val = io (withFile ("/home/koluacik/" <> filename) AppendMode (`hPutStrLn` val))

isTabber :: Window -> X Bool
isTabber = runQuery (fmap (tabberWmClass `isSuffixOf`) appName)

getLastChild :: Window -> X (Maybe Window)
getLastChild win = withDisplay $ \disp -> do
  (_, _, children) <- io (queryTree disp win)
  return $ safeLast children

safeLast :: [a] -> Maybe a
safeLast [] = Nothing
safeLast xs = Just . last $ xs

getPointerOffset :: Window -> X (Int, Int)
getPointerOffset win = do
  (_, _, _, oX, oY, _, _, _) <- withDisplay (\d -> io $ queryPointer d win)
  return (fromIntegral oX, fromIntegral oY)

getWindowPlacement :: WindowAttributes -> (Int, Int, Int, Int)
getWindowPlacement wa = (fromIntegral $ wa_x wa, fromIntegral $ wa_y wa, fromIntegral $ wa_width wa, fromIntegral $ wa_height wa)

getWindowUnderCursor :: X (Maybe Window)
getWindowUnderCursor = do
  root <- asks theRoot
  (_, _, selWin, _, _, _, _, _) <- withDisplay (\d -> io $ queryPointer d root)
  case selWin of
    0 -> pure Nothing
    win -> pure . Just $ win

visualizedMouseDrag :: Window -> X () -> X ()
visualizedMouseDrag window done = withDisplay $ \dpy ->
  withWindowAttributes dpy window $ \wa -> do
    -- focus window
    (offsetX, offsetY) <- getPointerOffset window
    let (winX, winY, winWidth, winHeight) = getWindowPlacement wa

    mouseDrag
      ( \posX posY ->
          let rect =
                Rectangle
                  (fromIntegral (fromIntegral winX + (posX - fromIntegral offsetX)))
                  (fromIntegral (fromIntegral winY + (posY - fromIntegral offsetY)))
                  (fromIntegral winWidth)
                  (fromIntegral winHeight)
           in sendMessage $ DraggingWindow window rect
      )
      (sendMessage DraggingStopped >> done)


getNonTabber :: X [Window]
getNonTabber = do
  gets (index . windowset) >>= filterM (fmap not <$> isTabber)

getTabbers :: X [Window]
getTabbers = do
  a <- gets (index . windowset)
  filterM isTabber a

dmenuTabber :: X Window
dmenuTabber = do
  tabbers <- map show <$> getTabbers
  selectedTabber <- dmenu tabbers
  dumpToFile' "selected_tabber" selectedTabber
  let tabberXID :: Window = read selectedTabber
  return tabberXID

dmenuNonTabber :: X Window
dmenuNonTabber = do
  nonTabbers <- map show <$> getNonTabber
  selectedWin <- dmenu nonTabbers
  dumpToFile' "selected_window" selectedWin
  let tabberXID :: Window = read selectedWin
  return tabberXID

dmenuReparent :: X ()
dmenuReparent = do
  dumpToFile' "run" "run"
  asks (handleEventHook . config)
  src <- dmenuNonTabber
  dst <- dmenuTabber
  reparentWindow' src dst
  io $ threadDelay 100000

debugHandleEvent :: XConfig a -> XConfig a
debugHandleEvent xconf = xconf {handleEventHook =  debugEventsHook <> debugHandleEventHook <> (handleEventHook xconf)}

debugHandleEventHook :: Event -> X All
debugHandleEventHook (AnyEvent {ev_event_type = reparentNotify, ev_serial=serial, ev_window=window}) = do
  root <- asks theRoot
  if window == root
    then pure mempty
    else do
      dumpToFile' "event" ("notification received " <> show serial <> " " <> show window)
      withDisplay (\dpy -> io $ mapWindow dpy window)
      return (All True)

debugHandleEventHook _ = pure mempty