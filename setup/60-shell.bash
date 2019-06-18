set -e

echo "Configuring shell..."

if [[ -e "$HOME/zsh" ]]; then
  echo "Oh My Zsh custom directory already exists."
else
  echo "Linking Oh My Zsh custom directory..."
  ln -s "$HOME/dotfiles/zsh" "$HOME/zsh"
fi

if [[ "/usr/local/bin/zsh" == "$SHELL" ]]; then
  echo "Brew zsh is already the current shell."
else
  if grep -Fxq /usr/local/bin/zsh /etc/shells; then
    echo "Brew zsh is already a standard shell."
  else
    echo "Adding brew zsh as a standard shell..."
    sudo sh -c 'echo /usr/local/bin/zsh > /etc/shells'
  fi

  echo "Setting brew zsh as the current shell..."
  chsh -s /usr/local/bin/zsh
fi

if [[ -e "$HOME/.oh-my-zsh" ]]; then
  echo "Oh My Zsh already installed."
else
  echo "Installing Oh My Zsh..."
  git clone git://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"
fi
