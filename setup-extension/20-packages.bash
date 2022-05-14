set -e

if [[ -f "$EXTENSION_DOTFILES_PATH/dotfiles/Brewfile" ]]; then
  echo "Installing Homebrew packages for $EXTENSION_NAME..."
  brew bundle "--file=$EXTENSION_DOTFILES_PATH/dotfiles/Brewfile"
else
  echo "No Homebrew packages found for $EXTENSION_NAME."
fi
