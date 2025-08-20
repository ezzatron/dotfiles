{ lib, ... }:
{
  programs.zsh = {
    enable = true;

    initContent = lib.mkOrder 1500 ''
      # include iTerm shell integration
      [[ "$TERM_PROGRAM" == "iTerm.app" ]] && source "$HOME/.config/iterm2/shell-integration.zsh"

      # include VSCode shell integration
      # see https://code.visualstudio.com/docs/terminal/shell-integration
      [[ "$TERM_PROGRAM" == "vscode" ]] && source "$(code --locate-shell-integration-path zsh)"

      # include 1Password CLI completions
      # see https://developer.1password.com/docs/cli/get-started/#shell-completion
      eval "$(op completion zsh)"; compdef _op op

      # include Grit completions
      # see https://github.com/jmalloc/grit#:~:text=eval%20%22%24(grit-,shell%2Dintegration,-)%22
      eval "$(grit shell-integration)"

      # modify path here, otherwise it gets clobbered by Homebrew
      export PATH="$HOME/bin:$PATH"
      export PATH="$HOME/.asdf/shims:$PATH"
    '';

    autosuggestion = {
      enable = true;
    };

    historySubstringSearch = {
      enable = true;
    };

    siteFunctions = {
      ghce = builtins.readFile ./zsh-function-ghce.zsh;
      ghcs = builtins.readFile ./zsh-function-ghcs.zsh;

      # override standard git commands with aliases
      git = ''
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

      # outputs the Git repo slug (e.g. ezzatron/dotfiles)
      git-slug = ''
        if ! URL="$(git config --get remote.origin.url)"; then
          return 1
        fi

        if [[ "$URL" =~ [:/]([^/:]+/[^/]+)\.git$ ]]; then
          echo "''${match[1]}"
        elif [[ "$1" == '--fuzzy' ]]; then
          echo "???/$(basename "$(pwd)")"
        else
          return 1
        fi
      '';

      # defines an iTerm user variable containing the current Git slug
      #
      # this is used to display the slug in an iTerm "badge"
      # see https://iterm2.com/documentation-badges.html
      iterm2_print_user_vars = ''
        iterm2_set_user_var gitSlug "$(git-slug)"
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
