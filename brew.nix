{
  brews = [
    "cloudflare-wrangler" # For testing against Cloudflare Worker runtime. Nix package installation takes forever.
    "jmalloc/grit/grit" # No Nix package.
    "mas" # To avoid mas getting uninstalled every time.
  ];

  casks = [
    "1password-cli"
    "1password"
    "aldente"
    "calibre"
    "chatgpt"
    "discord"
    "docker-desktop"
    "figma"
    "google-chrome"
    "guitar-pro"
    "iina"
    "iterm2"
    "keyboardcleantool"
    "messenger"
    "microsoft-edge"
    "rider"
    "scroll-reverser"
    "slack"
    "steam"
    "visual-studio-code"

    {
      name = "firefox@developer-edition";
      args = {
        language = "en-GB";
      };
    }
  ];

  masApps = {
    "1Password for Safari" = 1569813296;
    "MusicHarbor" = 1440405750;
    "Pixelmator Pro" = 1289583905;
    "TestFlight" = 899247664;
    "Xcode" = 497799835;
  };
}
