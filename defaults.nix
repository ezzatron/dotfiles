{ user, ... }:
{
  NSGlobalDomain = {
    # turn off font smoothing (better for Retina displays, but worse for non-Retina)
    AppleFontSmoothing = 0;

    # use dark mode always
    AppleInterfaceStyle = "Dark";

    # Enable moving focus in dialogs with Tab and Shift Tab
    AppleKeyboardUIMode = 2;

    # Do key repeat instead of alternate characters
    ApplePressAndHoldEnabled = false;

    # Set a blazingly fast keyboard repeat rate
    KeyRepeat = 2;
    InitialKeyRepeat = 25;

    # Enable tap-to-click
    "com.apple.mouse.tapBehavior" = 1;

    # Enable volume change feedback beep
    "com.apple.sound.beep.feedback" = 1;

    # Disable auto correct and other substitutions
    NSAutomaticCapitalizationEnabled = false;
    NSAutomaticDashSubstitutionEnabled = false;
    NSAutomaticPeriodSubstitutionEnabled = false;
    NSAutomaticQuoteSubstitutionEnabled = false;
    NSAutomaticSpellingCorrectionEnabled = false;

    # use 24-hour time format
    AppleICUForce24HourTime = true;
  };

  SoftwareUpdate = {
    # Automatic updates
    AutomaticallyInstallMacOSUpdates = true;
  };

  dock = {
    # Disable the Dock by default
    autohide = true;
    autohide-delay = 1000.0;

    # Right-oriented Dock
    orientation = "right";

    # Show only open applications in the Dock
    static-only = true;

    # Wipe all (default) app icons from the Dock
    persistent-apps = [ ];

    # Show hidden dock items as translucent
    showhidden = true;

    # Set the dock icon size
    tilesize = 64;

    # Speed up Mission Control animations
    expose-animation-duration = 0.1;

    # Top-left hot corner turns on screen saver
    wvous-tl-corner = 5;

    # Top-right hot corner turns off screen
    wvous-tr-corner = 10;

    # Bottom-right hot corner is disabled
    wvous-br-corner = 1;

    # Bottom-left hot corner is disabled
    wvous-bl-corner = 1;

    # Don’t show Dashboard as a Space
    dashboard-in-overlay = true;
  };

  trackpad = {
    # Enable tap-to-click
    Clicking = true;
  };

  universalaccess = {
    # Disable animation when switching screens or opening apps
    reduceMotion = true;
  };

  screencapture = {
    # Save screenshots to a dedicated directory
    location = "${user.home}/Screenshots";

    # Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
    type = "png";
  };

  finder = {
    # Allow Finder to be quit normally
    QuitMenuItem = true;

    # Show the Finder path bar
    ShowPathbar = true;

    # Show the Finder status bar
    ShowStatusBar = true;

    # Use list view in all Finder windows by default
    FXPreferredViewStyle = "Nlsv";

    # Keep directories at the top when sorting in Finder
    _FXSortFoldersFirst = true;

    # Use the home directory as the default location for new Finder windows
    NewWindowTarget = "Home";

    # Finder should search the current directory by default
    FXDefaultSearchScope = "SCcf";

    # Turn off automatic Desktop icons
    ShowExternalHardDrivesOnDesktop = false;
    ShowHardDrivesOnDesktop = false;
    ShowMountedServersOnDesktop = false;
    ShowRemovableMediaOnDesktop = false;

    # Delete Bin items after 30 days
    FXRemoveOldTrashItems = true;
  };

  CustomUserPreferences = {
    NSGlobalDomain = {
      # use ISO-style dates
      AppleICUDateFormatStrings = {
        "1" = "y-MM-dd";
        "2" = "y-MM-dd";
        "3" = "y-MM-dd";
        "4" = "y-MM-dd";
      };
    };

    ".GlobalPreferences" = {
      # Set programmer-friendly word break characters
      AppleTextBreakLocale = "en_US_POSIX";
    };

    "com.apple.finder" = {
      # Hide Finder recent tags
      ShowRecentTags = false;

      # Open folders in new Finder windows instead of tabs
      FinderSpawnTab = false;
    };

    "com.apple.dock" = {
      # Use command key modifier for hot corners
      wvous-tl-modifier = 1048576;
      wvous-tr-modifier = 1048576;
      wvous-bl-modifier = 1048576;
      wvous-br-modifier = 1048576;
    };

    "com.apple.menuextra.clock" = {
      # Set menu clock format
      DateFormat = "EEE MMM d HH:mm a";
    };

    "com.apple.dashboard" = {
      # Disable Dashboard
      mcx-disabled = true;
    };

    "com.apple.commerce" = {
      # Automatic App Store app updates
      AutoUpdate = true;
    };

    "com.apple.dt.Xcode" = {
      # Force Xcode to use the built-in version of Git for installing dependencies
      IDEPackageSupportUseBuiltinSCM = "YES";
    };

    "com.googlecode.iterm2" = {
      # Don’t display the annoying prompt when quitting iTerm
      PromptOnQuit = false;
      OnlyWhenMoreTabs = false;

      # Don't display tips
      NoSyncPermissionToShowTip = false;
      NoSyncTipsDisabled = true;

      # Enable automatic updates
      SUEnableAutomaticChecks = true;

      # Use preferences managed by home-manager
      PrefsCustomFolder = "${user.home}/.config/iterm2";
      LoadPrefsFromCustomFolder = true;
    };

    "com.valvesoftware.steam.streamingclient" = {
      # Disable window closing shortcuts for Steam remote play
      NSUserKeyEquivalents = "{Close=\"\\U200b\";\"Quit steamstreamingclient\"=\"~\\Uf707\";}";
    };
  };
}
