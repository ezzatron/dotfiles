set -e

echo "Installing apps..."

brew tap caskroom/versions
brew cask install \
    1password \
    authy \
    docker \
    eqmac \
    google-backup-and-sync \
    google-chrome \
    guitar-pro \
    iterm2 \
    postman \
    scroll-reverser \
    slack \
    spotify \
    steam \
    sublime-text
brew cask install firefox-developer-edition --language=en-GB
