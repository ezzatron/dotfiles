set -e

[ -e "$HOME/bin" ] || mkdir -p "$HOME/bin"
[ -e "$HOME/go" ] || mkdir -p "$HOME/go"

echo "Installing basic packages..."

gem install --user-install \
    pygments.rb \
    travis

brew tap jmalloc/grit

brew install \
    awscli \
    colordiff \
    git \
    grit \
    go \
    hardlink-osx \
    imagemagick \
    jq \
    mysql-client \
    node@10 \
    node \
    pgcli \
    vlc \
    watch \
    wdiff \
    wifi-password \
    yarn \
    zsh \
    zsh-autosuggestions \
    zsh-completions \
    zsh-syntax-highlighting

brew link --force mysql-client

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

if [[ -e "$HOME/.oh-my-zsh" ]]; then
    echo "Oh My Zsh already installed."
else
    echo "Installing Oh My Zsh..."
    git clone git://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"
fi
