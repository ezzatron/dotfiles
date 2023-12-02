set -e

[ -e "$HOME/Library/Filters" ] || mkdir -p "$HOME/Library/Filters"

shopt -s nullglob

for FILE in "$HOME/dotfiles/dotfiles/filters/"*.qfilter; do
  if [[ -e "$HOME/Library/Filters/$(basename $FILE)" ]]; then
    echo "Filter $(basename $FILE) already installed."
    continue
  fi

  echo "Installing $(basename $FILE) filter..."
  cp "$FILE" "$HOME/Library/Filters"
done
