set -e

[ -e "$HOME/bin" ] || mkdir -p "$HOME/bin"

echo "Installing basic packages..."

gem install --user-install \
    pygments.rb \
    travis

brew install \
    ghi \
    git \
    hub \
    zsh \
    zsh-autosuggestions \
    zsh-completions \
    zsh-history-substring-search \
    zsh-syntax-highlighting


echo "Installing zsh..."

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

echo "Installing Oh My Zsh..."
git clone git://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"
