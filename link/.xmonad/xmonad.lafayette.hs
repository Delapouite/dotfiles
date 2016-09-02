-- list of xK_… vars available at /usr/include/X11/keysymdef.h
-- or use xev to find key numbers

import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.GridSelect
import XMonad.Actions.NoBorders
import XMonad.Actions.Submap

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops

import XMonad.Layout.Accordion
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.Column
import XMonad.Layout.Dishes
import XMonad.Layout.Grid
import XMonad.Layout.LimitWindows
import XMonad.Layout.MultiToggle
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Reflect
import XMonad.Layout.Renamed
import XMonad.Layout.Spiral

import XMonad.Util.Run (spawnPipe)

import Data.Map (fromList)
import Data.Monoid
import System.IO
import System.Exit

import qualified XMonad.StackSet as W

-- KEYS - 5 rows :
-- F* row: media controls
-- Numbers row: 11 workspaces
-- Upper row: 3 screens & free for app customs
-- Home row: 4 free for app customs & shift apps & moves
-- Bottom row : xmonad

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.

myWorkspaces = ["z", "vi", "fx", "cr"] ++ map show [4..10]

-- GridSelect color scheme
myColorizer = colorRangeFromClassName
  (0x00, 0x2B, 0x36) --lowest inactive bg
  (0x93, 0xA1, 0xA1) --highest inactive bg
  (0xDC, 0x32, 0x2F) --active bg
  (0xCC, 0xCC, 0xCC) --inactive fg
  (0xFF, 0xFF, 0xFF) --active fg

-- GridSelect theme
myGSConfig = (buildDefaultGSConfig myColorizer)
  { gs_cellheight  = 150
  , gs_cellwidth   = 300
  , gs_cellpadding = 10
  }

-- Key bindings. Add, modify or remove key bindings here.
myKeys conf@XConfig {XMonad.modMask = modm} = fromList $
  -- Right pinky keys

  -- Launch a terminal
  [ ((modm,               xK_Return   ), spawn $ XMonad.terminal conf)
  -- Launch ranger
  , ((modm .|. shiftMask, xK_Return   ), spawn "xterm -e \"ranger\"")
  -- Launch a terminal in cwd
  , ((modm,               xK_BackSpace), spawn "xterm -e \"cd `xcwd` && /bin/zsh\"")
  -- Launch ranger in cwd
  , ((modm .|. shiftMask, xK_BackSpace), spawn "xterm -e \"cd `xcwd` && ranger\"")
  -- Close focused window
  , ((modm,               xK_Escape   ), kill)
  -- Restart xmonad
  , ((modm,               xK_Delete   ), spawn "xmonad --recompile; xmonad --restart")
  -- Quit xmonad
  , ((modm .|. shiftMask, xK_Delete   ), io exitSuccess)


  -- Function keys

  -- Sound volume
  , ((modm,               xK_F1 ), spawn "amixer set Master toggle")
  , ((modm,               xK_F2 ), spawn "amixer set Master 3%-")
  , ((modm,               xK_F3 ), spawn "amixer set Master 3%+")
  , ((modm,               xK_F4 ), spawn "amixer set Mic toggle")

  -- Screen brightness
  , ((modm,               xK_F5 ), spawn "xbacklight -10")
  , ((modm,               xK_F6 ), spawn "xbacklight +10")

  -- Keyboard (zsh "bepo" alias non available)
  , ((modm,               xK_F11), spawn "kbswitch.sh fr")
  , ((modm,               xK_F12), spawn "kbswitch.sh bepo")

  -- Launch applications
  , ((modm,               xK_p      ), spawn "dmenu_run")

  -- MPD controls
  , ((modm,               xK_Left   ), spawn "mpc prev")
  , ((modm,               xK_Right  ), spawn "mpc next")
  , ((modm,               xK_Up     ), spawn "mpc toggle")
  , ((modm,               xK_Down   ), spawn "mpc random")
  , ((modm,               xK_Page_Up), spawn "mpd-fav")


  -- Window mgmt
  , ((modm, xK_x), submap . fromList $

    -- Show grid
    [ ((0, xK_g), goToSelected myGSConfig)
    -- Toggle border
    , ((0, xK_b), withFocused toggleBorder)
    -- Reset the layouts on the current workspace to default
    , ((0, xK_space), setLayout $ XMonad.layoutHook conf)
    -- Push floating window back into tiling
    , ((0, xK_f), withFocused $ windows . W.sink)
    -- Resize viewed windows to the correct size
    , ((0, xK_r), refresh)
    ])


  -- Layouts
  , ((modm, xK_space), submap . fromList $

      -- All (whole)
      [ ((0, xK_w), setLayout $ Layout allLayouts)
      -- Rotate through the available layouts
      , ((0, xK_n), sendMessage NextLayout)
      -- Reflection (true mirror!)
      , ((0, xK_x), sendMessage $ Toggle REFLECTX)
      , ((0, xK_y), sendMessage $ Toggle REFLECTY)

      -- Accordion
      , ((0, xK_a), setLayout $ Layout accordions)
      -- Full
      , ((0, xK_f), setLayout $ Layout Full)
      -- Grid
      , ((0, xK_g), setLayout $ Layout Grid)
      -- Columns
      , ((0, xK_c), setLayout $ Layout columnsFirst)
      -- Rows
      , ((0, xK_r), setLayout $ Layout rowsFirst)
      -- Dishes (split)
      , ((0, xK_d), setLayout $ Layout dishesFirst)
      -- Curtains (vsplit)
      , ((0, xK_v), setLayout $ Layout curtainsFirst)
      -- Binary Repartition
      , ((0, xK_b), setLayout $ Layout emptyBSP)
      -- Spiral
      , ((0, xK_s), setLayout $ Layout spiralLayout)
      -- Tiers
      , ((0, xK_t), setLayout $ Layout tiersFirst)
      -- Halves
      , ((0, xK_h), setLayout $ Layout halvesFirst)
      ])


  -- Vim Arrows

  -- Move focus to the next window
  , ((modm,               xK_Tab  ), windows W.focusDown)
  , ((modm,               xK_j    ), windows W.focusDown)
  -- Swap the focused window with the next window
  , ((modm .|. shiftMask, xK_Tab  ), windows W.swapDown)
  , ((modm .|. shiftMask, xK_j    ), windows W.swapDown)

  -- Move focus to the previous window
  , ((modm,               xK_k    ), windows W.focusUp)
  -- Swap the focused window with the previous window
  , ((modm .|. shiftMask, xK_k    ), windows W.swapUp)

  -- Move focus to the master window
  , ((modm,               xK_m    ), windows W.focusMaster)
  -- Swap the focused window and the master window
  , ((modm .|. shiftMask, xK_m    ), windows W.swapMaster)

  -- Shrink the master area
  , ((modm,               xK_h    ), sendMessage Shrink)

  -- Expand the master area
  , ((modm,               xK_l    ), sendMessage Expand)


  -- Arrows

  -- Move to prev workspace
  , ((modm .|. shiftMask, xK_Left ), prevWS)

  -- Move to next workspace
  , ((modm .|. shiftMask, xK_Right), nextWS)

  -- Increment the number of windows in the master area
  , ((modm .|. shiftMask, xK_Up   ), sendMessage $ IncMasterN 1)

  -- Decrement the number of windows in the master area
  , ((modm .|. shiftMask, xK_Down ), sendMessage $ IncMasterN (-1))


  -- Firefox

  , ((modm, xK_f), submap . fromList $

      -- Launch
      [ ((0, xK_x), spawn "firefox")
      -- Sites
      , ((0, xK_g), spawn "firefox github.com")
      , ((0, xK_i), spawn "firefox game-icons.net")
      , ((0, xK_s), spawn "firefox stackoverflow.com")
      ])


  -- Chromium

  , ((modm, xK_c), submap . fromList $

      -- Launch
      [ ((0, xK_x), spawn "chromium")
      -- Sites
      , ((0, xK_g), spawn "chromium github.com")
      , ((0, xK_i), spawn "chromium game-icons.net")
      , ((0, xK_m), spawn "chromium gmail.com")
      , ((0, xK_s), spawn "chromium stackoverflow.com")
      , ((0, xK_t), spawn "chromium tweetdeck.twitter.com")
      ])
  ]

  ++

  -- Numbers row

  -- mod-[` 1 .. 0], Switch to workspace N
  -- mod-shift-[~ ! .. )], Move client to workspace N
  [((mask .|. modm, key), windows $ f i)
    | (i, key) <- zip (XMonad.workspaces conf)
      [ xK_grave
      , xK_1
      , xK_2
      , xK_3
      , xK_4
      , xK_5
      , xK_6
      , xK_7
      , xK_8
      , xK_9
      , xK_0
      ]
    , (f, mask) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

  ++

  -- Upper row

  -- mod-{a,z,e}, Switch to physical/Xinerama screens 1, 2, or 3
  -- mod-shift-{a,z,e}, Move client to screen 1, 2, or 3
  [((mask .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
    -- following 2 lines are generator yielding tuples for the comprehension

    -- [0..] is the 2nd arg because zip is lazy right
    | (key, sc) <- zip [xK_q, xK_w, xK_e] [0..]
    , (f, mask) <- [(W.view, 0), (W.shift, shiftMask)]]


-- Mouse bindings: default actions bound to mouse events
myMouseBindings XConfig {XMonad.modMask = modm} = fromList

  -- mod-button1, Set the window to floating mode and move by dragging


  [ ((modm, button1), \w -> focus w >> mouseMoveWindow w
                                     >> windows W.shiftMaster)

  -- mod-button2, Raise the window to the top of the stack
  , ((modm, button2), \w -> focus w >> windows W.shiftMaster)

  -- mod-button3, Set the window to floating mode and resize by dragging
  , ((modm, button3), \w -> focus w >> mouseResizeWindow w
                                     >> windows W.shiftMaster)
  ]


-- Layouts:

-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- Note that each layout is separated by ||| which denotes layout choice.

re name = renamed [Replace name]

-- g key, f key
gridFull = Grid ||| Full

-- a key
accordions = Accordion ||| Mirror Accordion

-- r key
rowsLayout = re "Rows" $ Column 1
-- c key
columnsLayout = re "Cols" $ Mirror rowsLayout

tiersLayouts = tiled ||| Mirror tiled
  where
    -- Default tiling algorithm partitions the screen into two panes
    tiled   = re "Tall 3" $ Tall nmaster delta ratio
    -- Default number of windows in the master pane
    nmaster = 1
    -- Default proportion of screen occupied by master pane
    ratio   = 2/3
    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

halvesLayouts = tiled ||| Mirror tiled
  where
    tiled   = re "Tall 2" $ Tall nmaster delta ratio
    nmaster = 1
    ratio   = 1/2
    delta   = 3/100

-- logs & daemons (horizontal split, s), rowsLayout variant
dishesLayout = re "Dishes 5" $ limitWindows 5 $ Dishes nmaster ratio
  where
    nmaster = 1
    ratio = 1/5

-- chats (vertical split, v key), columnsLayout variant
curtainsLayout = re "Curtains 5" $ Mirror dishesLayout

-- music & video players
noBordersLayout = re "NoBorders" $ noBorders Full

-- fibofun
spiralLayout = spiral(1/2)

-- mix layouts
columnsFirst = smartBorders $ columnsLayout ||| rowsLayout ||| gridFull
rowsFirst = smartBorders $ rowsLayout ||| columnsLayout ||| gridFull

tiersFirst = smartBorders $ tiersLayouts ||| halvesLayouts ||| gridFull
halvesFirst = smartBorders $ halvesLayouts ||| tiersLayouts ||| gridFull

dishesFirst = smartBorders $ dishesLayout ||| curtainsLayout ||| gridFull
curtainsFirst = smartBorders $ curtainsLayout ||| dishesLayout ||| gridFull

allLayouts = smartBorders $ columnsLayout ||| rowsLayout
                        ||| Grid
                        ||| halvesLayouts ||| tiersLayouts
                        ||| curtainsLayout ||| dishesLayout
                        ||| Full

myLayoutHook = mkToggle (single REFLECTX) $
               mkToggle (single REFLECTY) $
                (onWorkspace  "z"  rowsFirst $
                 onWorkspace  "vi" dishesFirst $
                 onWorkspace  "4"  columnsFirst $
                 onWorkspace  "8"  halvesFirst $
                 onWorkspace  "9"  tiersFirst $
                 onWorkspace  "10" noBordersLayout $
                                   allLayouts)

-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to always float a particular program,
-- or have a client always appear on a particular workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.

myManageHook :: ManageHook
myManageHook = composeAll
  [ className =? "Firefox"        --> doShift "2"
  , className =? "Chromium"       --> doShift "3"
  , className =? "Deadbeef"       --> doShift "9"
  , resource  =? "desktop_window" --> doIgnore
  , resource  =? "kdesktop"       --> doIgnore
--  https://www.reddit.com/r/xmonad/comments/4cnjhi/fullscreen_video_in_firefox/
  , isFullscreen --> doFullFloat ]

-- Event handling

-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.

myEventHook = handleEventHook defaultConfig <+> fullscreenEventHook

-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.

myLogHook = return ()

-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--

myStartupHook = return ()

-- Pretty Print for xmobar
myPP = xmobarPP {
  ppCurrent = xmobarColor "#D33682" "" . wrap "<" ">",
  ppVisible = wrap "(" ")",
  ppHidden = id,
  ppHiddenNoWindows = const "",
  ppTitle = xmobarColor "#FFFFFF" "",
  ppLayout = xmobarColor "#6C71C4" "",
  ppSep = " | "
}
-- Show/hide xmobar
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs

myConfig = defaultConfig {
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

main = xmonad =<< statusBar "xmobar" myPP toggleStrutsKey myConfig
