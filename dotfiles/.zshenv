setopt no_global_rcs
source "$HOME/.zshenv.secure"

if [[ $SHLVL = 1 ]]; then
    export GOPATH="$HOME/go"

    export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
    export PATH="$GOPATH/bin:$PATH"
    export PATH="$HOME/.gem/ruby/2.0.0/bin:$PATH"
    export PATH="$HOME/.composer/vendor/bin:$PATH"
    export PATH="$HOME/bin:$PATH"
    export PATH="vendor/bin:node_modules/.bin:$PATH"

    export HOMEBREW_GITHUB_API_TOKEN="$GITHUB_TOKEN"

    export GIT_PATH="$HOME/git"
    export GITHUB_PATH="$GIT_PATH/hub"
fi
