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

echo "Installing Oh My Zsh..."
chsh -s /usr/local/bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
