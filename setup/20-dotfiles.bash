set -e

echo "Installing dotfiles..."

for FILE in "$DOTFILES_PATH/dotfiles/".* "$DOTFILES_PATH/dotfiles/"*; do
  NAME=$(basename $FILE)

  if [[ "." == $NAME || ".." == $NAME ]]; then
    continue
  fi

  if [ -e "$HOME/$NAME" ]; then
    echo "$NAME already exists."
  else
    echo "Linking $NAME..."
    ln -s $FILE "$HOME/$NAME"
  fi
done
