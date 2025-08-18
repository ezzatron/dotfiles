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
              ];

              casks = [
                "1password-cli"
                "1password"
                "aldente"
                "calibre"
                "chatgpt"
                "discord"
                "docker"
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
                  args = { language = "en-GB"; };
                }
              ];

              masApps = {
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
          };
        }

        (
          { pkgs, ... }:
          {
            environment.systemPackages = [
              pkgs.adrs
              pkgs.asdf-vm
              pkgs.bun
              pkgs.clang-tools # To format .proto files
              pkgs.colordiff
              pkgs.deno
              pkgs.diff-so-fancy
              pkgs.direnv
              pkgs.evans
              pkgs.gh
              pkgs.git
              pkgs.go
              pkgs.jq
              pkgs.kubectl
              pkgs.kubectx
              pkgs.kubernetes-helm
              pkgs.mob
              pkgs.nixfmt-rfc-style # To format .nix files
              pkgs.nodejs_24
              pkgs.protobuf
              pkgs.terraform
              pkgs.unixtools.watch
              pkgs.vale
              pkgs.z-lua
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
                CustomUserPreferences = {
                  "com.googlecode.iterm2" = {
                    # Don’t display the annoying prompt when quitting iTerm
                    PromptOnQuit = false;
                    OnlyWhenMoreTabs = false;

                    # Use preferences managed by home-manager
                    PrefsCustomFolder = "${user.home}/.config/iterm2";
                    LoadPrefsFromCustomFolder = true;
                  };
                };
              };
            };

            users.users.${user.name} = user;
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
