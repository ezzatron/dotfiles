{ pkgs, ... }:
{
  home = {
    stateVersion = "25.11";

    sessionVariables = {
      # Match "word" characters in line editor with tools like VSCode
      WORDCHARS = "_";
    };

    activation = {
      postActivation = ''
        echo "Creating user directories..."
        mkdir -p "$HOME/bin"
        mkdir -p "$HOME/Screenshots"

        echo "Installing asdf plugins..."
        ${pkgs.asdf-vm}/bin/asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
      '';
    };
  };

  programs = {
    home-manager = {
      enable = true;
    };
  };

  imports = [
    ./home/asdf.nix
    ./home/aws.nix
    ./home/bat.nix
    ./home/direnv.nix
    ./home/filters.nix
    ./home/git.nix
    ./home/iterm.nix
    ./home/mob.nix
    ./home/ssh.nix
    ./home/starship.nix
    ./home/z-lua.nix
    ./home/zsh.nix
  ];
}
