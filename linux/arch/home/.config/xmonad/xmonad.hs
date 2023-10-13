-- =========
--  Imports
-- =========
import Colors.DarkPalette             -- personal colors, defined in ./lib/Colors/DarkPalette.hs

import Control.Monad (liftM2)
import Graphics.X11.ExtraTypes.XF86   -- bind media keys
import System.Exit                    -- provides exitWith to exit xmonad
import XMonad
import XMonad.Actions.CycleWS         -- cycle through WSs, toggle last WS
import XMonad.Actions.FloatSnap       -- snap floats to corners of the screen etc.
import XMonad.Actions.Warp            -- banish mouse pointer
import XMonad.Hooks.EwmhDesktops      -- use EWMH hints
import XMonad.Hooks.ManageDocks       -- automatica/lly manage dock-type programs
import XMonad.Hooks.ManageHelpers     -- provides isDialog
import XMonad.Hooks.StatusBar         -- add status bar such as xmobar
import XMonad.Hooks.StatusBar.PP      -- configure status bar printing printing
import XMonad.Hooks.UrgencyHook       -- colorize urgent WSs
import XMonad.Hooks.WindowSwallowing  -- will swallow the terminal when opening an app (until closes)
import XMonad.Layout.NoBorders        -- provides smartBorders, noBorders
import XMonad.Layout.Renamed          -- custom layout names
import XMonad.Layout.Spacing          -- pad windows with some spacing
import XMonad.Layout.Tabbed           -- tabbed windows layout
import XMonad.Prompt                  -- customize prompts
import XMonad.Prompt.ConfirmPrompt
import XMonad.Util.Cursor             -- set cursor
import XMonad.Util.EZConfig           -- easily configure keybindings
import XMonad.Util.Dmenu
import XMonad.Util.NamedScratchpad    -- temporary floating console
import XMonad.Util.Ungrab             -- allow releasing XMonad's keyboard grab (for screenshots etc.)
import qualified XMonad.StackSet as W -- provides greedyView and RationalRect

-- ======
--  Main
-- ======
main = xmonad
     . ewmhFullscreen
     . ewmh
     . withEasySB mySB defToggleStrutsKey -- <M-b> ToggleStruts
     . docks
     $ myConfig


myTerminal = "WINIT_X11_SCALE_FACTOR=1.9 alacritty" -- Sets default terminal (adaping the size for my old eyes)
myConfig = withUrgencyHook NoUrgencyHook def
    { terminal           = myTerminal
    , modMask            = mod4Mask
    , borderWidth        = 2
    , normalBorderColor  = myBrightBlack
    , focusFollowsMouse  = True                 -- Whether focus follows the mouse pointer.
    , clickJustFocuses   = False                -- Whether clicking also passes the click to the window
    , focusedBorderColor = myYellow
    , workspaces         = ["dev", "www", "comm", "sys", "media", "blog"]
    , startupHook        = myStartupHook
    , manageHook         = myManageHook
    , layoutHook         = myLayoutHook
    , handleEventHook    = myHandleEventHook
    }
    `additionalKeysP` myKeys

myFont = "xft:Caskaydia:size=12:antialias=true"

-- ========
--  Bar
-- ========
mySB = statusBarProp "xmobar ~/.config/xmonad/xmobar/xmobarrc.hs" (pure myPP)

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

myPP = xmobarPP
    { ppCurrent = xmobarColor myBrightYellow "" . wrap "<box type=Bottom width=2> " " </box>"
    , ppHidden  = pad
    , ppUrgent  = xmobarColor myBrightYellow myRed . wrap " " " "
    , ppSep     = "<fc=" ++ myWhite ++ "> <fn=1>|</fn> </fc>"
    , ppWsSep   = ""
    , ppTitle   = xmobarColor myBrightGreen "" . pad
    , ppLayout  = xmobarColor myBrightMagenta ""
    , ppVisible = xmobarColor myYellow "" . wrap "[" "]"                   -- visible in secondary monitor
    , ppExtras  = [ windowCount ]
    }

-- =============
--  Keybindings
-- =============
myKeys =
    [
    -- Basics
      ( "M-<Backspace>"  , toggleWS                                                    )
    , ( "M-<Return>"     , spawn myTerminal                                            )
    , ( "M-S-<Space>"    , sendMessage NextLayout                                      )
    , ( "M-w"            , kill                                                        )
    , ( "M-S-w"          , confirmPrompt myConfirm "exit?" $ io (exitWith ExitSuccess) )
    , ( "M-S-r"          , spawn myRecompileCmd                                        )
    , ( "M-S-v"          , spawn myClipMenuSelect                                      )

    -- Navigation
    , ( "M-<Tab>"        , windows W.focusUp                                           ) -- tab last
    , ( "M-<Escape>"     , moveTo Next (Not emptyWS)                                   ) -- tab next workspace
    , ( "M-S-<Escape>"   , moveTo Prev (Not emptyWS)                                   ) -- tab prev workspace
    , ( "M-S-t"          , withFocused $ windows . W.sink                              ) -- Push window back into tiling
    , ( "M-a"            , windows W.swapMaster                                        ) -- Swap window focus
    , ( "M-<Right>"      , sendMessage Expand                                          ) -- Expand master window
    , ( "M-<Left>"       , sendMessage Shrink                                          ) -- Shrink master window
    , ( "M-<Down>"       , nextScreen                                                  ) -- Changes focus to the next monitor
    , ( "M-S-<Down>"     , shiftNextScreen                                             ) -- Pushes current window to the other monitor
    , ( "M-="            , refresh                                                     ) -- Reset windows to defaut size ! NOT WORKING

    -- Common programs
    , ( "M-q"            , spawn "brave"                                              )
    , ( "M-S-q"          , spawn "notify-send TODO"                                   )
    , ( "M-v"            , spawn "copyq menu &"                                       )

    -- Scratchpad
    , ( "M-t"            , namedScratchpadAction scratchpads "terminal"               )

    -- Prompts
    -- , ( "M-<Space>"      , spawn myDmenuCmd                                        )
    , ( "M-<Space>"      , spawn "rofi -show drun"                                    )
    , ( "<Print>"        , unGrab >> spawn myScreenshotCmd                            )
    ]

myScreenshotCmd   = "flameshot gui"

myDmenuOptions = "-fn 'Caskaydia'" ++ " -nb '" ++ myBlack ++ "' -nf '" ++ myBrightYellow ++ "' -sb '" ++ myRed ++ "' -sf '" ++ myBrightWhite ++ "' -i"
myRecompileCmd    = "xmonad --recompile && xmonad --restart"
myDmenuCmd        = "dmenu_run " ++ myDmenuOptions
myClipMenuSelect  = "clipmenu " ++ myDmenuOptions

-- =============
--  startupHook
-- =============
myStartupHook = do
    setDefaultCursor xC_left_ptr

-- ============
--  manageHook
-- ============
-- To find the property name associated with a program, use  xprop | grep WM_CLASS and click on the client you're interested in.
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
myManageHook =
        manageSpecific
    <+> namedScratchpadManageHook scratchpads
    where
    manageSpecific = composeOne
        [ className =? "Brave-browser"              -?> viewShift "www"
        , className =? "Microsoft Teams - Preview"  -?> viewShift "comm"
        , className =? "Whatsapp-for-linux"         -?> viewShift "comm"
        , className =? "TelegramDesktop"            -?> viewShift "comm"
        , className =? "zoom "                      -?> viewShift "comm"
        , className =? "vlc"                        -?> viewShift "media"
        , className =? "Spotify"                    -?> viewShift "media" -- NOT WORKING
        , className =? "mpv"                        -?> viewShift "media"
        , className =? "obsidian"                   -?> viewShift "blog"
        , isDialog                                  -?> doCenterFloat
        ]
        where
        viewShift = doF . liftM2 (.) W.greedyView W.shift
-- composeAll . concat $
--    [ [ className =? "Brave-browser"              --> viewShift "www"        ]
--    , [ className =? "Microsoft Teams - Preview"  --> viewShift "comm"       ]
--    , [ className =? "Whatsapp-for-linux"         --> viewShift "comm"       ]
--    , [ className =? "TelegramDesktop"            --> viewShift "comm"       ]
--    , [ className =? "zoom "                      --> viewShift "comm"       ]
--    , [ className =? "vlc"                        --> viewShift "media"      ]
--    , [ className =? "Spotify"                    --> viewShift "media"      ] -- NOT WORKING
--    , [ className =? "mpv"                        --> viewShift "media"      ]
--    , [ isDialog                                  --> doCenterFloat          ]
--    ]
--    where
--        viewShift = doF . liftM2 (.) W.greedyView W.shift

-- ============
--  layoutHook
-- ============
myLayoutHook = smartBorders $ avoidStruts $  myTabbed ||| myFull ||| myTiled
    where
        myTabbed = renamed [Replace " <fn=2>\xe47a</fn> "] $ tabbedBottom shrinkText def
            { fontName            = myFont
            , activeColor         = myBrightBlack
            , activeTextColor     = myBrightYellow
            , activeBorderColor   = myBrightYellow
            , inactiveColor       = myBlack
            , inactiveTextColor   = myOffWhite
            , inactiveBorderColor = myBrightBlack
            , urgentColor         = myRed
            , urgentTextColor     = myBrightYellow
            , urgentBorderColor   = myBrightBlack
            , decoHeight          = 18
            }
        myTiled       = renamed [Replace " <fn=2>\xf0db</fn> "] $ spacingWithEdge 5 $ Tall nmaster delta ratio
        nmaster       = 1     -- number of master windows
        ratio         = 2/3   -- master-to-slave window ratio
        delta         = 3/100 -- percent of screen to increment by when resizing
        myFull        = renamed [Replace " <fn=2>\xf424</fn> "] $ Full

-- ============
--  handleEventHook
-- ============
myHandleEventHook = swallowEventHook (className =? "Alacritty" <||> className =? "XTerm") (return True)

-- ============
--  scratchpads
-- ============
scratchpads =
    [
    NS "terminal" spawnTerm findTerm manageTerm
--    NS "terminal" "alacritty" (resource =? "scratchpad") defaultFloating
    ]
    where
    spawnTerm  = myTerminal ++ " -t scratchpad"
    findTerm   = title =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
        where
        h = 0.9
        w = 0.9
        t = 0.95 -h
        l = 0.95 -w

-- ============
--  utils
-- ============
myConfirm = def
  { position          = CenteredAt 0.3 0.3
  , alwaysHighlight   = True
  , height = 100
  , promptBorderWidth = 2
  , borderColor = myYellow
  , font              = "xft:Caskaydia:size=12"
  , bgColor = myBlack
  , fgColor = myWhite
  }
