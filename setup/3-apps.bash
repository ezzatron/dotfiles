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

SUBLIME_CONFIG_PATH="$HOME/Library/Application Support/Sublime Text 3/Local"

if [ -f "$SUBLIME_CONFIG_PATH/License.sublime_license" ]; then
    echo "Sublime Text license already exists."
else
    echo "Fetching Sublime Text license from LastPass..."
    mkdir -p "$SUBLIME_CONFIG_PATH"
    lpass show "Personal/Sublime Text License" --notes \
        > "$SUBLIME_CONFIG_PATH/License.sublime_license"
fi

open "/Applications/Dropbox.app"
open "/Applications/Google Chrome.app"
open "/Applications/iTerm.app"
open "/Applications/Spotify.app"
