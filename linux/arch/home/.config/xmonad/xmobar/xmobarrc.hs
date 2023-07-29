
Config
  { font = "Caskaydia",
    additionalFonts =
      [ "Font Awesome 6 Free Solid",
        "Font Awesome 6 Brands"
      ],
    dpi = 96,
    bgColor = "#282c34",
    fgColor = "#ff6c6b",
    -- Position TopSize and BottomSize take 3 arguments:
    --   an alignment parameter (L/R/C) for Left, Right or Center.
    --   an integer for the percentage width, so 100 would be 100%.
    --   an integer for the minimum pixel height for xmobar, so 24 would force a height of at least 24 pixels.
    --   NOTE: The height should be the same as the trayer (system tray) height.
    position = TopSize C 100 24,
    -- position = Static { xpos = 50 , ypos = 5, width = 1820, height = 24 },
    lowerOnStart = True,
    hideOnStart = False,
    allDesktops = True,
    persistent = True,
    iconRoot = ".xmonad/xpm/", -- default: "."
    commands =
      [ 
        -- Cpu usage in percent
        Run Cpu ["-t", "<fn=2>\xf108</fn>  cpu: <total>%", "-H", "50", "--high", "red"] 20,
        -- Ram used number and percent
        Run Memory ["-t", "<fn=2>\xf233</fn>  mem: <usedratio>%"] 20,
        -- Disk space free
        Run DiskU [("/", "<fn=2>\xf0c7</fn> <free>")] [] 60,
        -- Echos an "up arrow" icon in front of the uptime output.
        -- Run Com "echo" ["<fn=2>\xf0aa</fn>"] "uparrow" 3600,
        -- Uptime
        -- Run Uptime ["-t", "uptime: <days>d <hours>h"] 360,
        -- Wifi status
        Run Com "echo" ["<fn=2>\xf0aa</fn>"] "wifi_echo" 3600,
        -- Run Com "sh" ["-c", "~/.local/bin/wireless"] "wifi" 3600,
        -- Echos a "bell" icon in front of the pacman updates.
        -- , Run Com "echo" ["<fn=2>\xf0f3</fn>"] "bell" 3600
        -- Check for pacman updates (script found in .local/bin)
        -- , Run Com "paru -Qu | wc -l" [] "pacupdate" 36000
        -- Echos a "battery" icon in front of the pacman updates.
        Run Com "echo" ["<fn=2>\xf242</fn>"] "baticon" 3600,
        -- Battery
        Run BatteryP ["BAT0"] ["-t", "<left>%"] 360,
        -- Current Keyboard Layout
        Run Com "sh" ["-c", "~/.local/bin/keylang-current"] "curlang" 50,
        -- Time and date
        Run Date "<fn=2>\xf017</fn> %Y %m %d (%H:%M) %a" "date" 50,
        -- Script that dynamically adjusts xmobar padding depending on number of trayer icons.
        Run Com ".config/xmobar/trayer-padding-icon.sh" [] "trayerpad" 20,
        -- Prints out the left side items such as workspaces, layout, etc.
        Run XMonadLog
        -- Run UnsafeStdinReader
      ],
    sepChar = "%",
    alignSep = "}{",
    template = "    %XMonadLog% }{ <box type=Bottom width=2 mb=2 color=#ecbe7b><fc=#ecbe7b><action=`alacritty -e htop`>%cpu%</action></fc></box>      <box type=Bottom width=2 mb=2 color=#ff6c6b><fc=#ff6c6b><action=`alacritty -e htop`>%memory%</action></fc></box>    <box type=Bottom width=2 mb=2 color=#a9a1e1><fc=#a9a1e1><action=`alacritty -e htop`>%disku%</action></fc></box>    <box type=Bottom width=2 mb=2 color=#da8548><fc=#da8548>%baticon%  %battery%</fc></box>    <box type=Bottom width=2 mb=1 color=#98be65><fc=#98be65><action=`keylang-toggle.sh`>%curlang%</action></fc></box>     <box type=Bottom width=2 mb=2 color=#46d9ff><fc=#46d9ff><action=`emacsclient -c -a 'emacs' --eval '(doom/window-maximize-buffer(dt/year-calendar))'`>%date%</action></fc></box>      "
  }
