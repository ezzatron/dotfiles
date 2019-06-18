set -e

echo "Installing packages..."

gem install --user-install \
  pygments.rb \
  travis

brew bundle "--file=$HOME/Brewfile"
brew link --force mysql-client
