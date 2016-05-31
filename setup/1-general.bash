set -e

[ -e "$HOME/bin" ] || mkdir -p "$HOME/bin"

echo "Installing basic packages..."

gem install --user-install \
    pygments.rb \
    travis

brew install \
    bash-completion \
    ghi \
    git \
    hub
