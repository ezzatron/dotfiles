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
          let
            brew = import ./brew.nix;
          in
          {
            homebrew = {
              enable = true;
              onActivation.cleanup = "zap";
              onActivation.autoUpdate = true;
              onActivation.upgrade = true;
              taps = builtins.attrNames config.nix-homebrew.taps;

              inherit (brew) brews casks masApps;
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
            environment.systemPackages = import ./packages.nix { inherit pkgs; };

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

              defaults = import ./defaults.nix { inherit user; };

              activationScripts = {
                postActivation = {
                  enable = true;
                  text = ''
                    echo "Activating settings..."

                    # Use 24-hour time on the lock screen
                    defaults write /Library/Preferences/.GlobalPreferences AppleICUForce24HourTime -bool true

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

              zsh = {
                interactiveShellInit = ''
                  # Enable zsh-history-substring-search
                  source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
                '';
              };
            };
          }
        )
      ];
    in
    {
      darwinConfigurations."ccd1c1b3" = nix-darwin.lib.darwinSystem {
        modules = modules ++ [
          (
            { lib, ... }:
            {
              networking.hostName = "erins-mbp-ccd1c1b3";
              system.activationScripts.postActivation.text = lib.mkAfter ''
                echo "Setting computer name..."
                scutil --set ComputerName "Erin's MacBook Pro ccd1c1b3"
              '';
            }
          )
        ];
      };

      darwinConfigurations."2c3ba79f" = nix-darwin.lib.darwinSystem {
        modules = modules ++ [
          (
            { lib, ... }:
            {
              networking.hostName = "erins-mbp-2c3ba79f";
              system.activationScripts.postActivation.text = lib.mkAfter ''
                echo "Setting computer name..."
                scutil --set ComputerName "Erin's MacBook Pro 2c3ba79f"
              '';
            }
          )
        ];
      };

      darwinConfigurations."50abbd64" = nix-darwin.lib.darwinSystem {
        modules = modules ++ [
          (
            { lib, ... }:
            {
              networking.hostName = "erins-mbp-50abbd64";
              system.activationScripts.postActivation.text = lib.mkAfter ''
                echo "Setting computer name..."
                scutil --set ComputerName "Erin's Work MacBook Pro 50abbd64"
              '';
            }
          )
        ];
      };
    };
}
