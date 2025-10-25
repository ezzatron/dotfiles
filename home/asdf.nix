{ ... }:
{
  home = {
    sessionVariables = {
      ASDF_NODEJS_AUTO_ENABLE_COREPACK = "true";
      ASDF_NODEJS_LEGACY_FILE_DYNAMIC_STRATEGY = "latest_installed";
    };

    file.asdfrc = {
      enable = true;
      force = true;
      source = ./asdf.ini;
      target = ".asdfrc";
    };

    file.default-npm-packages = {
      enable = true;
      force = true;
      source = ./asdf-default-npm-packages.txt;
      target = ".default-npm-packages";
    };
  };
}
