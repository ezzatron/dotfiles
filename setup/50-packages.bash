set -e

echo "Installing packages..."

brew bundle "--file=$HOME/Brewfile"

echo "Setting up automatic Homebrew upgrades..."

brew autoupdate start --upgrade
