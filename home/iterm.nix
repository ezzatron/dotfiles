{ pkgs, ... }:
{
  home = {
    file.iterm = {
      enable = true;
      source = ./iterm.plist;
      target = ".iterm/com.googlecode.iterm2.plist";
      force = true;
    };
  };
}
