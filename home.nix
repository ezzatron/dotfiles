{ ... }:
{
  home = {
    stateVersion = "25.11";

    sessionVariables = {
      # Match "word" characters in line editor with tools like VSCode
      WORDCHARS = "_";
    };

    activation = {
      postActivation = ''
        mkdir -p "$HOME/bin"
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
    ./home/asdf.nix
    ./home/aws.nix
    ./home/bat.nix
    ./home/direnv.nix
    ./home/git.nix
    ./home/iterm.nix
    ./home/ssh.nix
    ./home/starship.nix
    ./home/z-lua.nix
    ./home/zsh.nix
  ];
}
