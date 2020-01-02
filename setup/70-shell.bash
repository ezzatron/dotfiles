set -e

echo "Configuring shell..."

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

if [[ -e "$HOME/.zprezto" ]]; then
  echo "Prezto already installed."
else
  echo "Installing Prezto..."
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"
fi


if [[ -e "$HOME/.iterm2_shell_integration.zsh" ]]; then
  echo "iTerm shell integration already installed."
else
  echo "Installing iTerm shell integration..."
  curl -L https://iterm2.com/shell_integration/zsh -o "$HOME/.iterm2_shell_integration.zsh"
fi
