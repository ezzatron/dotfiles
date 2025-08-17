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
              pkgs.git
              pkgs.iterm2
              pkgs.jq
              pkgs.nixfmt-rfc-style
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
