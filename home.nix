{ pkgs, ... }:
{
  home = {
    stateVersion = "25.11";

    sessionVariables = {
      PATH = "$HOME/bin:$PATH";
    };

    activation = {
      screenshotsDir = ''
        mkdir "$HOME/Screenshots"
      '';
    };
  };

  programs = {
    home-manager = {
      enable = true;
    };
  };

  imports = [
    ./home/aws.nix
    ./home/git.nix
    ./home/iterm.nix
    ./home/ssh.nix
    ./home/starship.nix
    ./home/zsh.nix
  ];
}
