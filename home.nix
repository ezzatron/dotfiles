{ pkgs, ... }:
{
  home = {
    sessionVariables = {
      PATH = "$HOME/bin:$PATH";
    };
  };

  imports = [
    ./home/iterm.nix
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "25.11";
}
