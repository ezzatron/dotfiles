{ lib, ... }:
{
  programs.zsh = {
    enable = true;

    initContent = lib.mkMerge [
      (lib.mkOrder 500 ''
        # use a dumb terminal for VSCode's built-in terminal
        [[ "$TERM_PROGRAM" == "vscode" ]] && export TERM=dumb
      '')

      (lib.mkOrder 1500 ''
        # include private env vars if present
        [[ -f "$HOME/.config/private.zsh" ]] && source "$HOME/.config/private.zsh"

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
        export PATH="$HOME/.dotnet/tools:$PATH"
        export PATH="$HOME/bin:$PATH"
        export PATH="$HOME/.asdf/shims:$PATH"
      '')
    ];

    autosuggestion = {
      enable = true;
    };

    historySubstringSearch = {
      enable = true;
    };

    siteFunctions = {
      ghce = builtins.readFile ./zsh-function-ghce.zsh;
      ghcs = builtins.readFile ./zsh-function-ghcs.zsh;
      git = builtins.readFile ./zsh-function-git.zsh;
      git-slug = builtins.readFile ./zsh-function-git-slug.zsh;
      iterm2_print_user_vars = builtins.readFile ./zsh-function-iterm2_print_user_vars.zsh;
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
