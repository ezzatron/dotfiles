setopt no_global_rcs

if [[ $SHLVL = 1 ]]; then
  source "$HOME/.zshenv.secure"

  if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR="vim"
  else
    export EDITOR="subl -n -w"
  fi

  export BROWSER="open"
  export DEFAULT_USER="$USER"
  export HOMEBREW_GITHUB_API_TOKEN="$GH_TOKEN"
  export LESS="-g -i -M -R -S -w -z-4"

  export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
  export GOPATH="$(go env GOPATH)"
  export PATH="$GOPATH/bin:$PATH"
  export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"
  export PATH="$HOME/.composer/vendor/bin:$PATH"
  export PATH="$HOME/bin:$PATH"
  export PATH="vendor/bin:node_modules/.bin:$PATH"
fi
