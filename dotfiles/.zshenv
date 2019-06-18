setopt no_global_rcs
source "$HOME/.zshenv.secure"

if [[ $SHLVL = 1 ]]; then
  export DEFAULT_USER="$USER"

  export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
  export GOPATH="$(go env GOPATH)"
  export PATH="$GOPATH/bin:$PATH"
  export PATH="$HOME/.gem/ruby/2.3.0/bin:$PATH"
  export PATH="$HOME/.composer/vendor/bin:$PATH"
  export PATH="$HOME/bin:$PATH"
  export PATH="vendor/bin:node_modules/.bin:$PATH"

  export HOMEBREW_GITHUB_API_TOKEN="$GITHUB_TOKEN"
fi
