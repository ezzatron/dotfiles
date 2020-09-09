set -e

echo "Installing packages..."

brew bundle "--file=$HOME/Brewfile"
brew link --force mysql-client
