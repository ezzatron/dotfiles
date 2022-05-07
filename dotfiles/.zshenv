setopt no_global_rcs

if [[ $SHLVL = 1 ]]; then
  source "$HOME/.zshenv.secure"

  if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR="vim"
  else
    export EDITOR="code --wait"
  fi

  export BROWSER="open"
  export DEFAULT_USER="$USER"
  export HOMEBREW_GITHUB_API_TOKEN="$GH_TOKEN"
  export LESS="-g -i -M -R -S -w -z-4"

  if [[ -x /usr/libexec/path_helper ]]; then
    eval "$(/usr/libexec/path_helper -s)"
  fi

  if [[ -e /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -e /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi

  export GOPATH="$(go env GOPATH)"
  export PATH="$GOPATH/bin:$PATH"
  export PATH="$HOME/.composer/vendor/bin:$PATH"
  export PATH="$HOME/.krew/bin:$PATH"
  export PATH="$HOME/bin:$PATH"
  export PATH="vendor/bin:$PATH"
  export PATH="node_modules/.bin:$PATH"

  [[ -f "$HOME/.zshenv.workfiles" ]] && source "$HOME/.zshenv.workfiles"
fi
