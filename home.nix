{ pkgs, ... }:
{
  home = {
    stateVersion = "25.11";

    sessionVariables = {
      # Run executables from ~/bin
      PATH = "$HOME/bin:$PATH";

      # Match "word" characters in line editor with tools like VSCode
      WORDCHARS = "_";
    };

    activation = {
      screenshotsDir = ''
        mkdir -p "$HOME/Screenshots"
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
    ./home/direnv.nix
    ./home/git.nix
    ./home/iterm.nix
    ./home/ssh.nix
    ./home/starship.nix
    ./home/z-lua.nix
    ./home/zsh.nix
  ];
}
