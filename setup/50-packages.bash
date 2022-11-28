set -e

echo "Installing packages..."

brew bundle "--file=$HOME/Brewfile"

echo "Setting up automatic Homebrew upgrades..."

mkdir -p "$HOME/Library/LaunchAgents"
brew autoupdate start
