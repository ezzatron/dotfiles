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
    ./home/aws.nix
    ./home/git.nix
    ./home/iterm.nix
    ./home/ssh.nix
    ./home/starship.nix
    ./home/zsh.nix
  ];
}
