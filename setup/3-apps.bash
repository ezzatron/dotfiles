set -e

echo "Installing apps..."

brew tap caskroom/versions
brew cask install \
    1password \
    authy \
    docker \
    dropbox \
    eqmac \
    google-chrome \
    iterm2 \
    scroll-reverser \
    slack \
    spotify \
    steam \
    sublime-text
brew cask install firefox --language=en-GB
