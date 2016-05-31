setopt no_global_rcs
source "$HOME/.zshenv.secure"

if [[ $SHLVL = 1 ]]; then
    export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
    export PATH="$HOME/.composer/vendor/bin:$PATH"
    export PATH="$HOME/bin:$PATH"
    export PATH="vendor/bin:node_modules/.bin:$PATH"

    export HOMEBREW_GITHUB_API_TOKEN="$GITHUB_TOKEN"
fi
