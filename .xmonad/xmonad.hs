import XMonad
import XMonad.Layout.Tabbed
import XMonad.Layout.Spiral
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
	, layoutHook = smartBorders $ (( avoidStruts $  tabbed shrinkText defaultTheme ||| Mirror Accordion ||| layoutHook defaultConfig) ||| Full)
        , logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
	, terminal = "xterm"
	, workspaces = ["term", "code", "web"] ++ map show [4..8] ++ ["music"]
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "gnome-screensaver-command -l")
        , ((mod4Mask, xK_Print), spawn "sleep 0.2; scrot -s -e 'mv $f ~/pics/scrot/'")
        , ((controlMask, xK_Print), spawn "scrot -e 'mv $f ~/pics/scrot'")
        ]


