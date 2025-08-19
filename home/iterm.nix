{ iterm-shell-integration, ... }:
{
  home = {
    file.itermShell = {
      enable = true;
      force = true;
      source = iterm-shell-integration;
      target = ".config/iterm2/shell-integration.zsh";
    };

    file.itermPrefs = {
      enable = true;
      force = true;
      source = ./iterm.plist;
      target = ".config/iterm2/com.googlecode.iterm2.plist";
    };
  };
}
