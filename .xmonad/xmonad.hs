import XMonad
import XMonad.Layout.Tabbed
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import XMonad.Layout.NoBorders
import XMonad.Layout.Accordion

main = do
  xmproc <- spawnPipe "xmobar"
  xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
	, layoutHook = avoidStruts $ smartBorders  $  tabbed shrinkText defaultTheme ||| Mirror Accordion ||| layoutHook defaultConfig
        , logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
	, terminal = "konsole"
	, workspaces = ["term", "code", "web"] ++ map show [4..8] ++ ["music"]
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "gnome-screensaver-command -l")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        ]


