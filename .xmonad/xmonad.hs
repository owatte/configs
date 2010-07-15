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
import XMonad.Layout.PerWorkspace
import XMonad.Layout.IM
import Data.Ratio ((%))
import XMonad.Hooks.UrgencyHook

main = do
  xmproc <- spawnPipe "xmobar"
  xmonad $ withUrgencyHook NoUrgencyHook
         $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
	, layoutHook = smartBorders $ (avoidStruts $  tabbed shrinkText defaultTheme ||| Mirror Accordion ||| layoutHook defaultConfig)
        , logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
	, terminal = "xterm"
	, workspaces = ["term", "code", "web"] ++ map show [4..9]
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "gnome-screensaver-command -l")
        , ((mod4Mask, xK_Print), spawn "sleep 0.2; scrot -s -e 'mv $f ~/pics/scrot/'")
        , ((controlMask, xK_Print), spawn "scrot -e 'mv $f ~/pics/scrot'")
        -- multimedia keys
        --
        -- XF86AudioLowerVolume
        , ((0            , 0x1008ff11), spawn "aumix -v -2")
        -- XF86AudioRaiseVolume
        , ((0            , 0x1008ff13), spawn "aumix -v +2")
        -- XF86AudioMute
        , ((0            , 0x1008ff12), spawn "amixer -q set Master toggle")
        ]


