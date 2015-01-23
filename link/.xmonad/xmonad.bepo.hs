import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.GridSelect
import XMonad.Actions.NoBorders
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Dishes
import XMonad.Layout.LimitWindows
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Util.Run(spawnPipe)
import Data.Monoid
import System.IO
import System.Exit
import Graphics.X11.ExtraTypes.XF86

import qualified XMonad.StackSet as W
import qualified Data.Map as M

-- KEYS
-- F* row: medias
-- Numbers row: 11 workspaces
-- Upper row: 3 screens & free for app customs
-- Home row: apps & moves
-- Bottom row : xmonad

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
myWorkspaces = map show [0..10]

-- GridSelect color scheme
myColorizer = colorRangeFromClassName
  (0x00,0x2B,0x36) --lowest inactive bg
  (0x93,0xA1,0xA1) --highest inactive bg
  (0xDC,0x32,0x2F) --active bg
  (0xCC,0xCC,0xCC) --inactive fg
  (0xFF,0xFF,0xFF) --active fg

-- GridSelect theme
myGSConfig colorizer = (buildDefaultGSConfig myColorizer)
  { gs_cellheight  = 150
  , gs_cellwidth   = 300
  , gs_cellpadding = 10
  }

-- Key bindings. Add, modify or remove key bindings here.
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- Launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- Sound volume
    , ((0,               xF86XK_AudioMute       ), spawn "amixer set Master toggle")
    , ((0,               xF86XK_AudioLowerVolume), spawn "amixer set Master 3%-")
    , ((0,               xF86XK_AudioRaiseVolume), spawn "amixer set Master 3%+")
    , ((modm,            xK_F4                  ), spawn "amixer set Mic toggle")

    -- Screen brightness
    , ((modm,               xK_F5    ), spawn "xbacklight -10")
    , ((modm,               xK_F6    ), spawn "xbacklight +10")

    -- Launch applications
    , ((modm,               xK_p     ), spawn "dmenu_run")
    , ((0,                  xF86XK_Calculator), spawn "dmenu_run")
    , ((modm,               xK_d     ), spawn "deadbeef")
    , ((modm,               xK_f     ), spawn "firefox")
    , ((0,                  xF86XK_HomePage), spawn "firefox")
    , ((modm,               xK_g     ), spawn "chromium")
    , ((0,                  xF86XK_Mail), spawn "chromium")

    -- Bottom row, xmonad related

    , ((modm,               xK_agrave),  goToSelected $ myGSConfig myColorizer)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_y     ), refresh)

    -- Close focused window
    , ((modm .|. shiftMask, xK_x     ), kill)

    -- Push window back into tiling
    , ((modm,               xK_period), withFocused $ windows . W.sink)

    , ((modm,               xK_b     ), withFocused toggleBorder)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_question), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_question), spawn "xmonad --recompile; xmonad --restart")


    -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    -- Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_t     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_s     ), windows W.focusUp)

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster)

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_t     ), windows W.swapDown)

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_s     ), windows W.swapUp)

    -- Shrink the master area
    , ((modm,               xK_c     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_r     ), sendMessage Expand)

    -- Move to next workspace
    , ((modm,               xK_Left  ), prevWS)

    -- Move to next workspace
    , ((modm,               xK_Right ), nextWS)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_semicolon), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    -- , ((modm              , xK_y     ), sendMessage ToggleStruts)
    ]
    ++

    -- mod-[$ " .. / *], Switch to workspace N
    -- mod-shift-[$ " .. / *], Move client to workspace N
    -- use xev to find key numbers
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf)
            [ xK_dollar
            , xK_quotedbl
            , xK_guillemotleft
            , xK_guillemotright
            , xK_parenleft
            , xK_parenright
            , xK_at
            , xK_plus
            , xK_minus
            , xK_slash
            , xK_asterisk
            ]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    -- mod-{b,é,p}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{b,é,p}, Move client to screen 1, 2, or 3
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_b, xK_eacute, xK_p] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

-- Mouse bindings: default actions bound to mouse events
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    ]

-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- * NOTE: XMonad.Hooks.EwmhDesktops users must remove the obsolete
-- ewmhDesktopsLayout modifier from layoutHook. It no longer exists.
-- Instead use the 'ewmh' function from that module to modify your
-- defaultConfig as a whole. (See also logHook, handleEventHook, and
-- startupHook ewmh notes.)
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
tiersLayouts = tiled ||| Mirror tiled ||| Full ||| Grid
  where
    -- Default tiling algorithm partitions the screen into two panes
    tiled   = Tall nmaster delta ratio
    -- Default number of windows in the master pane
    nmaster = 1
    -- Default proportion of screen occupied by master pane
    ratio   = 2/3
    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

halvesLayouts = tiled ||| Mirror tiled ||| Full ||| Grid
  where
    tiled   = Tall nmaster delta ratio
    nmaster = 1
    ratio   = 1/2
    delta   = 3/100

-- logs & daemons
dishesLayout = limitWindows 5 $ Dishes nmaster ratio
  where
    nmaster = 1
    ratio = 1/5

-- chats
curtainsLayout = Mirror dishesLayout

dishesFirst = dishesLayout ||| curtainsLayout ||| Grid
curtainsFirst = curtainsLayout ||| dishesLayout ||| Grid

-- music & video players
noBordersLayout = noBorders $ Full

myLayoutHook = onWorkspace  "0"         dishesFirst $
               onWorkspace  "4"         curtainsFirst $
               onWorkspaces ["7", "8"]  halvesLayouts $
               onWorkspaces ["9", "10"] noBordersLayout $
                                        tiersLayouts

-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Firefox"        --> doShift "2"
    , className =? "Chromium"       --> doShift "3"
    , className =? "Deadbeef"       --> doShift "9"
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

-- Event handling

-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH event handling to your custom event hooks by
-- combining them with ewmhDesktopsEventHook.
myEventHook = mempty

-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH logHook actions to your custom log hook by
-- combining it with ewmhDesktopsLogHook.
myLogHook = return ()

-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add initialization of EWMH support to your custom startup
-- hook by combining it with ewmhDesktopsStartup.
myStartupHook = return ()


-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs

main = do
  xmonad $ defaultConfig {
    terminal           = "xterm",
    focusFollowsMouse  = True,
    borderWidth        = 2,
    normalBorderColor  = "#000000",
    focusedBorderColor = "#DC322F",
    modMask            = mod4Mask,
    workspaces         = myWorkspaces,

  -- key bindings
    keys               = myKeys,
    mouseBindings      = myMouseBindings,

  -- hooks, layouts
    layoutHook         = myLayoutHook,
    manageHook         = myManageHook,
    handleEventHook    = myEventHook,
    logHook            = myLogHook,
    startupHook        = myStartupHook
  }
