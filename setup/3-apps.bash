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
    sublime-text \
    vagrant \
    virtualbox
brew cask install firefox --language=en-GB

open "/Applications/Dropbox.app"
open "/Applications/Google Chrome.app"
open "/Applications/iTerm.app"
open "/Applications/Scroll Reverser.app"
open "/Applications/Spotify.app"
