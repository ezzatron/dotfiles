set -e

if [[ -f "$EXTENSION_DOTFILES_PATH/dotfiles/.config/grit.toml" ]]; then
  echo "Configuring Grit for $EXTENSION_NAME..."

  echo "# Generated file - DO NOT EDIT" > "$HOME/.config/grit.toml"
  echo >> "$HOME/.config/grit.toml"

  for FILE in "$HOME/dotfiles/extensions/"*/dotfiles/.config/grit.toml; do
    echo "# From $FILE" >> "$HOME/.config/grit.toml"
    cat "$FILE" >> "$HOME/.config/grit.toml"
  done
else
  echo "No Grit config found for $EXTENSION_NAME."
fi
