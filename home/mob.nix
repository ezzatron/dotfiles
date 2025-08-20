{ pkgs, ... }:
{
  home = {
    packages = [ pkgs.mob ];

    file.mob = {
      enable = true;
      force = true;
      source = ./mob.env;
      target = ".mob";
    };
  };
}
