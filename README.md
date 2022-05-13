# Personal dotfiles

## What is this repo?

This repo contains my personal ["dotfiles"]. In other words, the configuration
files for my terminal, shell, prompt, macOS, and other software.

## Features

- Semi-automated [installation]
- [macOS] customizations
- [Homebrew] for apps and packages
- [Prezto] for `zsh` customization
- [Powerlevel10k] for prompt customization
- [iTerm] customization
- [1Password] integration for `ssh`
- [Git] customizations, including signing with [GnuPG]
- [Touch ID] for `sudo`
- Can be extended with other (potentially private) dotfiles repos

## Installation

> ⚠️ This repo is not intended for installation by anyone other than myself. It
> makes a lot of assumptions about software that I use, and will not work for
> anyone else without heavy modification.

```shell
bash <(curl -fsSL https://raw.githubusercontent.com/ezzatron/dotfiles/main/install)
```

<!-- References -->

["dotfiles"]: https://wikipedia.org/wiki/Hidden_file_and_hidden_directory#Unix_and_Unix-like_environments
[1password]: https://1password.com/
[git]: https://git-scm.com/
[gnupg]: https://gnupg.org/
[homebrew]: https://brew.sh/
[installation]: #installation
[iterm]: https://iterm2.com/
[macos]: https://apple.com/macos/
[powerlevel10k]: https://github.com/romkatv/powerlevel10k
[prezto]: https://github.com/sorin-ionescu/prezto
[touch id]: https://wikipedia.org/wiki/Touch_ID
