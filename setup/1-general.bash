[ -e "$HOME/bin" ] || mkdir -p "$HOME/bin"

gem install --user-install \
    pygments.rb \
    travis

brew install \
    bash-completion \
    ghi \
    git \
    hub
