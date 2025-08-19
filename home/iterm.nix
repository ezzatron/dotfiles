{ pkgs, ... }:
{
  home = {
    file.iterm = {
      enable = true;
      force = true;
      source = ./iterm.plist;
      target = ".config/iterm2/com.googlecode.iterm2.plist";
    };
  };
}
