{ ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      shlvl = {
        disabled = false;
      };
    };
  };
}
