{
  brews = [
    "asdf" # Because nixpkgs unstable is outdated.
    "cloudflare-wrangler" # For testing against Cloudflare Worker runtime. Nix package installation takes forever.
    "dotnet@8" # Because nixpkgs unstable is currently broken.
    "jmalloc/grit/grit" # No Nix package.
    "mas" # To avoid mas getting uninstalled every time.
  ];

  casks = [
    "1password-cli"
    "1password"
    "aldente"
    "calibre"
    "chatgpt"
    "crystalfetch"
    "discord"
    "docker-desktop"
    "dotnet-sdk@8" # nixpkgs unstable is currently broken
    "figma"
    "google-chrome"
    "guitar-pro"
    "iina"
    "iterm2"
    "keyboardcleantool"
    "microsoft-edge"
    "miro"
    "rider"
    "scroll-reverser"
    "slack"
    "steam"
    "utm"
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
