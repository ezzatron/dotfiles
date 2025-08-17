{ pkgs, ... }:
{
  home = {
    file.iterm = {
      enable = true;
      source = ./iterm.plist;
      target = ".config/iterm2/com.googlecode.iterm2.plist";
      force = true;
    };
  };
}
