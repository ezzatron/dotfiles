# override standard git commands with aliases
git () {
  if [ "$1" = "show" ]; then
    command git x-show "${@:2}"
  else
    command git "$@"
  fi
}

# outputs the Git repo slug (e.g. ezzatron/dotfiles)
function git-slug () {
  if ! URL="$(git config --get remote.origin.url)"; then
    return 1
  fi

  if [[ "$URL" =~ [:/]([^/:]+/[^/]+)\.git$ ]]; then
    echo "${match[1]}"
  elif [[ "$1" == '--fuzzy' ]]; then
    echo "???/$(basename "$(pwd)")"
  else
    return 1
  fi
}

# defines an iTerm user variable containing the current Git slug
#
# this is used to display the slug in an iTerm "badge"
# see https://iterm2.com/documentation-badges.html
function iterm2_print_user_vars () {
  iterm2_set_user_var gitSlug "$(git-slug)"
}

# defines a custom Powerlevel10k prompt segment for Telepresence
#
# displays the current Telepresence container
function prompt_my_telepresencecontext() {
  if [[ -n "$TELEPRESENCE_CONTAINER" ]]; then
    p10k segment -i ' ' -b 1 -f 15 -t "$TELEPRESENCE_CONTAINER"
  fi
}

# include a shell script, but don't complain if it doesn't exist
function source-if-exists () {
  [ -f "$1" ] && source "$1"
}

# checks to see whether Touch ID is still enabled for sudo
# this happens after macOS updates
function touchid-sudo-check () {
  grep -q pam_tid /etc/pam.d/sudo || >&2 echo "WARNING: Touch ID is no longer enabled for sudo. Run touchid-sudo-enable to re-enable."
}

# enable Touch ID for sudo
function touchid-sudo-enable () {
  grep -q pam_tid /etc/pam.d/sudo || sudo sed -i.bak $'2i\\\nauth       sufficient     pam_tid.so\n' /etc/pam.d/sudo
}

# install an older version of a Homebrew formula
function brew-install-version () {
  FORMULA="$1"
  VERSION="$2"
  TAP="$3"

  if [[ -z "$FORMULA" || -z "$VERSION" ]]; then
    >&2 echo "Usage: $0 <formula> <version> [<tap>]"
    >&2 echo "Example: $0 kubernetes-cli 1.25"
    >&2 echo "Example: $0 telepresence-arm64 2.8.5 datawire/blackbird"

    return 1
  fi

  LOCAL_TAP="$USER/local-versions"

  if [[ -z "$TAP" ]]; then
    FULL_FORMULA="$FORMULA"
  else
    FULL_FORMULA="$TAP/$FORMULA"
  fi

  brew tap-new "$LOCAL_TAP" &>/dev/null || true
  brew extract --force --version="$VERSION" "$FULL_FORMULA" "$LOCAL_TAP"
  brew install "$LOCAL_TAP/$FORMULA@$VERSION"
  brew link --overwrite "$LOCAL_TAP/$FORMULA@$VERSION"
}
