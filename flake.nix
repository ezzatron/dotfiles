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
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
    }:
    let
      user = {
        name = "erin";
        home = "/Users/erin";
      };

      configuration =
        { pkgs, ... }:
        {
          environment.systemPackages = [
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
          };

          users.users.${user.name} = user;
        };
    in
    {
      darwinConfigurations."ccd1c1b3" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          {
            networking.hostName = "erins-mbp-ccd1c1b3";
          }
        ];
      };

      darwinConfigurations."2c3ba79f" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          {
            networking.hostName = "erins-mbp-2c3ba79f";
          }
        ];
      };
    };
}
