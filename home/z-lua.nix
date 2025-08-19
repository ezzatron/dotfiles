{ ... }:
{
  programs.z-lua = {
    enable = true;
    enableZshIntegration = true;
    options = [ "enhanced" ];
  };
}
