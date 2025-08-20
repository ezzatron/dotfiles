# Personal dotfiles

## What is this repo?

This repo contains my personal ["dotfiles"]. In other words, the configuration
files for my terminal, shell, prompt, macOS, and other software.

["dotfiles"]: https://wikipedia.org/wiki/Hidden_file_and_hidden_directory#Unix_and_Unix-like_environments

## Installation

> ⚠️ This repo is not intended for installation by anyone other than myself. It
> makes a lot of assumptions about software that I use, and will not work for
> anyone else without heavy modification.

```shell
bash <(curl -fsSL https://raw.githubusercontent.com/ezzatron/dotfiles/nix/install)
```

## TODO

- [ ] `gh` copilot extension
- [ ] `ghce` and `ghcs` aliases
- [ ] Update command
- [ ] Private environment variables
- [ ] Extended Finder view preferences
- [ ] Open apps on activate?
- [ ] Extension system

## Post-installation steps

- Start Docker
- Stop Chrome from asking to sign in with Google
  - Settings
  - Privacy and security
  - Site settings
  - Additional content settings
  - Third-party sign-in
  - Block sign-in prompts from identity services

## System defaults wanted

- Disable iTerm tip of the day
