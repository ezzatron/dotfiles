{
  description = "ezzatron's dotfiles flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    jmalloc-homebrew-grit = {
      url = "github:jmalloc/homebrew-grit";
      flake = false;
    };

    mac-app-util = {
      url = "github:hraban/mac-app-util";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    iterm-shell-integration = {
      url = "https://iterm2.com/shell_integration/zsh";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      jmalloc-homebrew-grit,
      mac-app-util,
      home-manager,
      iterm-shell-integration,
    }:
    let
      user = {
        name = "erin";
        home = "/Users/erin";
      };

      modules = [
        mac-app-util.darwinModules.default

        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            user = user.name;
            mutableTaps = false;
            autoMigrate = true;

            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
              "jmalloc/homebrew-grit" = jmalloc-homebrew-grit;
            };
          };
        }
        (
          { config, ... }:
          {
            homebrew = {
              enable = true;
              onActivation.cleanup = "zap";
              onActivation.autoUpdate = true;
              onActivation.upgrade = true;
              taps = builtins.attrNames config.nix-homebrew.taps;

              brews = [
                "cloudflare-wrangler" # For testing against Cloudflare Worker runtime. Nix package installation takes forever.
                "jmalloc/grit/grit" # No Nix package.
                "mas" # To avoid mas getting uninstalled every time.
              ];

              casks = [
                "1password-cli"
                "1password"
                "aldente"
                "calibre"
                "chatgpt"
                "discord"
                "docker-desktop"
                "figma"
                "google-chrome"
                "guitar-pro"
                "iina"
                "iterm2"
                "keyboardcleantool"
                "messenger"
                "microsoft-edge"
                "scroll-reverser"
                "slack"
                "steam"
                "visual-studio-code"

                {
                  name = "firefox@developer-edition";
                  args = {
                    language = "en-GB";
                  };
                }
              ];

              masApps = {
                "1Password for Safari" = 1569813296;
                "MusicHarbor" = 1440405750;
                "Pixelmator Pro" = 1289583905;
                "TestFlight" = 899247664;
              };
            };
          }
        )

        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            sharedModules = [
              mac-app-util.homeManagerModules.default
            ];
            users.${user.name} = import ./home.nix;
            backupFileExtension = "backup";
            extraSpecialArgs = {
              iterm-shell-integration = iterm-shell-integration;
            };
          };
        }

        (
          { pkgs, ... }:
          {
            environment.systemPackages = [
              pkgs.adrs
              pkgs.bun
              pkgs.clang-tools # To format .proto files
              pkgs.colordiff
              pkgs.deno
              pkgs.evans
              pkgs.gh
              pkgs.git
              pkgs.go
              pkgs.jq
              pkgs.kubectl
              pkgs.kubectx
              pkgs.kubernetes-helm
              pkgs.nixfmt-rfc-style # To format .nix files
              pkgs.nodejs_24
              pkgs.protobuf
              pkgs.terraform
              pkgs.unixtools.watch
              pkgs.vale
            ];

            fonts.packages = [
              pkgs.nerd-fonts.victor-mono
            ];

            nix = {
              settings = {
                experimental-features = "nix-command flakes";
              };
            };

            nixpkgs = {
              hostPlatform = "aarch64-darwin";
              config = {
                allowUnfree = true;
              };
            };

            system = {
              primaryUser = "erin";
              configurationRevision = self.rev or self.dirtyRev or null;
              stateVersion = 6;

              defaults = {
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

                    # Use preferences managed by home-manager
                    PrefsCustomFolder = "${user.home}/.config/iterm2";
                    LoadPrefsFromCustomFolder = true;
                  };

                  "com.valvesoftware.steam.streamingclient" = {
                    # Disable window closing shortcuts for Steam remote play
                    NSUserKeyEquivalents = "{Close=\"\\U200b\";\"Quit steamstreamingclient\"=\"~\\Uf707\";}";
                  };
                };
              };

              activationScripts = {
                postActivation = {
                  enable = true;
                  text = ''
                    echo "Activating settings..."
                    sudo -u ${user.name} /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
                  '';
                };
              };
            };

            users.users.${user.name} = user;

            security = {
              pam.services.sudo_local.touchIdAuth = true;
            };

            programs = {
              ssh = {
                knownHosts = {
                  github_ed25519 = {
                    hostNames = [ "github.com" ];
                    publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
                  };
                  github_ecdsa = {
                    hostNames = [ "github.com" ];
                    publicKey = "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=";
                  };
                  github_rsa = {
                    hostNames = [ "github.com" ];
                    publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCj7ndNxQowgcQnjshcLrqPEiiphnt+VTTvDP6mHBL9j1aNUkY4Ue1gvwnGLVlOhGeYrnZaMgRK6+PKCUXaDbC7qtbW8gIkhL7aGCsOr/C56SJMy/BCZfxd1nWzAOxSDPgVsmerOBYfNqltV9/hWCqBywINIR+5dIg6JTJ72pcEpEjcYgXkE2YEFXV1JHnsKgbLWNlhScqb2UmyRkQyytRLtL+38TGxkxCflmO+5Z8CSSNY7GidjMIZ7Q4zMjA2n1nGrlTDkzwDCsw+wqFPGQA179cnfGWOWRVruj16z6XyvxvjJwbz0wQZ75XK5tKSb7FNyeIEs4TT4jk+S4dhPeAUC5y+bDYirYgM4GC7uEnztnZyaVWQ7B381AK4Qdrwt51ZqExKbQpTUNn+EjqoTwvqNj4kqx5QUCI0ThS/YkOxJCXmPUWZbhjpCg56i+2aB6CmK2JGhn57K5mj0MNdBXA4/WnwH6XoPWJzK5Nyu2zB3nAZp+S5hpQs+p1vN1/wsjk=";
                  };
                };
              };
            };
          }
        )
      ];
    in
    {
      darwinConfigurations."ccd1c1b3" = nix-darwin.lib.darwinSystem {
        modules = modules ++ [
          {
            networking.hostName = "erins-mbp-ccd1c1b3";
          }
        ];
      };

      darwinConfigurations."2c3ba79f" = nix-darwin.lib.darwinSystem {
        modules = modules ++ [
          {
            networking.hostName = "erins-mbp-2c3ba79f";
          }
        ];
      };
    };
}
