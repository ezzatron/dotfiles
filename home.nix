{ pkgs, ... }:
{
  home = {
    stateVersion = "25.11";

    sessionVariables = {
      PATH = "$HOME/bin:$PATH";
    };
  };

  programs = {
    home-manager = {
      enable = true;
    };
  };

  imports = [
    ./home/iterm.nix
  ];
}
