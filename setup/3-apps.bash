set -e

echo "Installing apps..."

brew tap caskroom/versions
brew cask install \
    dockertoolbox \
    dropbox \
    google-chrome \
    iterm2 \
    slack \
    spotify \
    steam \
    sublime-text3
