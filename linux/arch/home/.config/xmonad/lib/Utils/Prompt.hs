import XMonad.Util.Dmenu

module Utils.Prompt where

confirm :: String -> X () -> X ()
confirm m f = do
  result <- dmenu [m]
  when (init result == m) f
