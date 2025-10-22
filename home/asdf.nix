{ ... }:
{
  home = {
    sessionVariables = {
      ASDF_NODEJS_LEGACY_FILE_DYNAMIC_STRATEGY = "latest_installed";
    };

    file.asdfrc = {
      enable = true;
      force = true;
      source = ./asdf.ini;
      target = ".asdfrc";
    };
  };
}
