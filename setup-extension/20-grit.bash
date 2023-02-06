set -e

if [[ -f "$EXTENSION_DOTFILES_PATH/dotfiles/grit.sources" ]]; then
  echo "Configuring Grit for $EXTENSION_NAME..."

  echo "# Generated file - DO NOT EDIT" > "$HOME/.config/grit.toml"
  echo >> "$HOME/.config/grit.toml"
  echo "[clone.sources]" >> "$HOME/.config/grit.toml"

  for FILE in "$HOME/dotfiles/extensions/"*/dotfiles/grit.sources; do
    echo "# From extension $EXTENSION_NAME" >> "$HOME/.config/grit.toml"
    cat "$FILE" >> "$HOME/.config/grit.toml"
  done
else
  echo "No Grit config found for $EXTENSION_NAME."
fi
