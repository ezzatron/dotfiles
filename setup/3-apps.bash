set -e

echo "Installing apps..."

brew tap caskroom/versions
brew cask install \
    docker \
    dropbox \
    firefox \
    google-chrome \
    iterm2-beta \
    scroll-reverser \
    slack \
    spotify \
    steam \
    sublime-text

open "/Applications/Dropbox.app"
open "/Applications/Google Chrome.app"
open "/Applications/iTerm.app"
open "/Applications/Scroll Reverser.app"
open "/Applications/Spotify.app"
