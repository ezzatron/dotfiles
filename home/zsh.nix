{ ... }:
{
  programs.zsh = {
    enable = true;

    initContent = builtins.readFile ./zsh-init-content.zsh;

    autosuggestion = {
      enable = true;
    };

    historySubstringSearch = {
      enable = true;
    };

    siteFunctions = {
      git = ''
        # override standard git commands with aliases

        if [ "$1" = "show" ]; then
          command git x-show "''${@:2}"
        elif [ "$1" = "push" ]; then
          # prevent use force push without lease
          if [ "$ALLOW_FORCE" != "true" ]; then
            for ARG in "''${@:2}"; do
              if [ "$ARG" = "-f" ] || [ "$ARG" = "--force" ]; then
                echo -e "\033[0;31mYou are trying to force push without lease. Use 'git push --force-with-lease' instead.\033[0m"
                return 1
              fi
            done
          fi

          command git "$@"
        else
          command git "$@"
        fi
      '';
    };

    syntaxHighlighting = {
      enable = true;
    };
  };

  home.shellAliases = {
    # Listing aliases
    # -h = human-readable sizes
    # -G = colorize output
    # -l = long format
    ls = "ls -hG";
    ll = "ls -lhG";
  };
}
