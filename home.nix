{ pkgs, ... }:
{
  home = {
    stateVersion = "25.11";

    sessionVariables = {
      # Options for less
      # I didn't write this, and I can't recall where it came from
      #
      # -g   = highlight single search matches instead of all matches
      # -i   = ignore case in searches if the search string is all lowercase
      # -M   = more verbose prompt
      # -R   = display raw control characters while maintaining screen appearance
      # -S   = chop long lines instead of folding
      # -w   = highlight the first new line after a forward page movement
      # -z-4 = set the scrolling window size to 4 lines less than the screen size
      LESS = "-g -i -M -R -S -w -z-4";

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
