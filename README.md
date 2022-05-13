# Personal dotfiles

## What is this repo?

This repo contains my personal ["dotfiles"], or the set configuration files I
use to configure my terminal, shell, and prompt, as well as macOS, and other
software. I also use this repo to set up new machines in a semi-automated
fashion.

Features include:

- macOS customizations
- [Homebrew] for apps and packages
- [Prezto] for `zsh` customization
- [Powerlevel10k] for prompt customization
- [iTerm] customization
- [1Password] integration for `ssh`
- [Git] customizations, including signing with [GnuPG]
- [Touch ID] for `sudo`

["dotfiles"]: https://wikipedia.org/wiki/Hidden_file_and_hidden_directory#Unix_and_Unix-like_environments
[1password]: https://1password.com/
[git]: https://git-scm.com/
[gnupg]: https://gnupg.org/
[homebrew]: https://brew.sh/
[iterm]: https://iterm2.com/
[powerlevel10k]: https://github.com/romkatv/powerlevel10k
[prezto]: https://github.com/sorin-ionescu/prezto
[touch id]: https://wikipedia.org/wiki/Touch_ID

## Installation

> ⚠️ This repo is not intended for installation by anyone other than myself. It
> makes a lot of assumptions about software that I use, and will not work for
> anyone else without heavy modification.

```shell
bash <(curl -fsSL https://raw.githubusercontent.com/ezzatron/dotfiles/main/install)
```
