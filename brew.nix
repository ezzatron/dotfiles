{
  brews = [
    "asdf" # Because nixpkgs unstable is outdated.
    "cloudflare-wrangler" # For testing against Cloudflare Worker runtime. Nix package installation takes forever.
    "d-kuro/tap/gwq" # No Nix package.
    "deno" # Frequently uncached in nixpkgs unstable for aarch64-darwin.
    "direnv" # Frequently uncached in nixpkgs unstable for aarch64-darwin.
    "jmalloc/grit/grit" # No Nix package.
    "mas" # To avoid mas getting uninstalled every time.
    "mise" # Frequently uncached in nixpkgs unstable for aarch64-darwin.
  ];

  casks = [
    "1password-cli"
    "1password"
    "aldente"
    "calibre"
    "chatgpt"
    "copilot-cli"
    "crystalfetch"
    "discord"
    "docker-desktop"
    "figma"
    "gcloud-cli"
    "google-chrome"
    "guitar-pro"
    "iina"
    "insomnia"
    "iterm2"
    "itermai"
    "keyboardcleantool"
    "logi-options+"
    "microsoft-edge"
    "scroll-reverser"
    "slack"
    "steam"
    "utm"
    "visual-studio-code"
    "voiceink"

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
    "Whatsapp" = 310633997;
  };
}
