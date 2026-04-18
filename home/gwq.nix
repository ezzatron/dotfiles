{ ... }:
{
  home = {
    file.gwq = {
      enable = true;
      force = true;
      source = ./gwq.toml;
      target = ".config/gwq/config.toml";
    };
  };
}
