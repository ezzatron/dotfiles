set -e

echo "Installing dotfiles..."

for FILE in "$HOME/dotfiles/dotfiles/".* "$HOME/dotfiles/dotfiles/"*; do
  NAME=$(basename $FILE)

  if [[ "." == $NAME || ".." == $NAME ]]; then
    continue
  fi

  if [[ -L "$HOME/$NAME" ]]; then
    echo "$NAME is already a symlink."
    continue
  fi

  if [[ -e "$HOME/$NAME" ]]; then
    BACKUP="$NAME.$(date -u +"%Y-%m-%dT%H:%M:%SZ").old"
    echo "Moving $NAME to $BACKUP..."
    mv "$HOME/$NAME" "$HOME/$BACKUP"
  fi

  echo "Linking $NAME..."
  ln -s $FILE "$HOME/$NAME"
done
