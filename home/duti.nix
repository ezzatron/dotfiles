{ pkgs, ... }:
{
  home = {
    packages = [ pkgs.duti ];

    file.duti = {
      enable = true;
      force = true;
      source = ./duti.conf;
      target = ".config/duti.conf";
    };

    activation = {
      setFileAssociations = ''
        echo "Setting file associations with duti..."
        ${pkgs.duti}/bin/duti ~/.config/duti.conf
      '';
    };
  };
}
