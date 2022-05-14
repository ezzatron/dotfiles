set -e

if [[ -f "$EXTENSION_DOTFILES_PATH/dotfiles/.gitconfig" ]]; then
  echo "Configuring Git for $EXTENSION_NAME..."

  echo "# Generated file - DO NOT EDIT
[include]" > "$HOME/.dotfiles-extensions.gitconfig"

  for FILE in "$HOME/dotfiles/extensions/"*/dotfiles/.gitconfig; do
    echo "  path = $FILE" >> "$HOME/.dotfiles-extensions.gitconfig"
  done
else
  echo "No Git config found for $EXTENSION_NAME."
fi
