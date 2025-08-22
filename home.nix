{ pkgs, ... }:
{
  home = {
    stateVersion = "25.11";

    sessionVariables = {
      # Use VSCode as the editor
      EDITOR = "code --wait";

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

      # Disable some Node.js warnings and always use type stripping
      NODE_OPTIONS = "--disable-warning=DeprecationWarning --disable-warning=ExperimentalWarning --experimental-strip-types";

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

        echo "Configuring advanced system defaults..."

        function plist-set-or-add () {
          local ENTRY="$1"
          local TYPE="$2"
          local VALUE="$3"
          local PLIST="$4"

          /usr/libexec/PlistBuddy -c "Set $ENTRY $VALUE" "$PLIST" ||
          /usr/libexec/PlistBuddy -c "Add $ENTRY $TYPE $VALUE" "$PLIST" ||
          echo "Unable to set or add plist with args:" "$@"
        }

        # Sort icon views by name
        plist-set-or-add :DesktopViewSettings:IconViewSettings:arrangeBy string name "$HOME/Library/Preferences/com.apple.finder.plist"
        plist-set-or-add :FK_StandardViewSettings:IconViewSettings:arrangeBy string name "$HOME/Library/Preferences/com.apple.finder.plist"
        plist-set-or-add :StandardViewSettings:IconViewSettings:arrangeBy string name "$HOME/Library/Preferences/com.apple.finder.plist"

        # Show item info in icon views
        plist-set-or-add :DesktopViewSettings:IconViewSettings:showItemInfo bool true "$HOME/Library/Preferences/com.apple.finder.plist"
        plist-set-or-add :FK_StandardViewSettings:IconViewSettings:showItemInfo bool true "$HOME/Library/Preferences/com.apple.finder.plist"
        plist-set-or-add :StandardViewSettings:IconViewSettings:showItemInfo bool true "$HOME/Library/Preferences/com.apple.finder.plist"

        # Minimize grid spacing in icon views
        plist-set-or-add :DesktopViewSettings:IconViewSettings:gridSpacing int 1 "$HOME/Library/Preferences/com.apple.finder.plist"
        plist-set-or-add :FK_StandardViewSettings:IconViewSettings:gridSpacing int 1 "$HOME/Library/Preferences/com.apple.finder.plist"
        plist-set-or-add :StandardViewSettings:IconViewSettings:gridSpacing int 1 "$HOME/Library/Preferences/com.apple.finder.plist"

        # Set the icon size in icon views
        plist-set-or-add :DesktopViewSettings:IconViewSettings:iconSize int 64 "$HOME/Library/Preferences/com.apple.finder.plist"
        plist-set-or-add :FK_StandardViewSettings:IconViewSettings:iconSize int 64 "$HOME/Library/Preferences/com.apple.finder.plist"
        plist-set-or-add :StandardViewSettings:IconViewSettings:iconSize int 64 "$HOME/Library/Preferences/com.apple.finder.plist"
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
