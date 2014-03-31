import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Util.Run
import XMonad.Util.EZConfig

myLayout = avoidStruts $ smartBorders tiled ||| smartBorders (Mirror tiled) ||| noBorders Full
    where
    tiled = Tall nmaster delta tiled_ratio
    nmaster = 1
    delta = 3/100
    tiled_ratio = 2/3

main = do

        xmonad $ defaultConfig	{
		 terminal = "sakura -t Terminal-chan" ,
		 modMask = mod4Mask ,
		 borderWidth = 0 ,

        layoutHook = myLayout,

--        normalBorderColor = "gray20",
--        focusedBorderColor = "gray80",


	}  {--`additionalKeysP`
           [
                ("<Print>", spawn "/usr/bin/scrot")
                --may or MAY NOT work
           ]



