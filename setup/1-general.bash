[ -e "$HOME/bin" ] || mkdir -p "$HOME/bin"

brew install \
    bash-completion \
    ghi \
    git \
    hub

gem install --user-install \
    travis
