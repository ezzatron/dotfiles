{ pkgs, ... }:
{
  home = {
    packages = [ pkgs.awscli2 ];

    file.aws = {
      enable = true;
      force = true;
      source = ./aws-config.ini;
      target = ".aws/config";
    };
  };
}
