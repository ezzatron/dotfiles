{ ... }:
{
  home = {
    file.aws = {
      enable = true;
      force = true;
      source = ./aws-config.ini;
      target = ".aws/config";
    };
  };
}
