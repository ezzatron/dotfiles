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

# defines a custom Powerlevel10k prompt segment for Docker
#
# displays the current Docker host, but only when it's remote
# this segment is configured to show regardless of which command is entered
# see .p10k.zsh for the configuration
function prompt_my_dockerremotecontext() {
  if [[ -n "$DOCKER_HOST" && "$DOCKER_HOST" != "unix:///var/run/docker.sock" ]]; then
    p10k segment -i ' ' -b 1 -f 15 -t "$DOCKER_HOST"
  fi
}

# defines a custom Powerlevel10k prompt segment for Docker
#
# displays the current Docker host, but only when it's local
# this segment is configured to show only when the docker command is entered
# see .p10k.zsh for the configuration
function prompt_my_dockerlocalcontext() {
  if [[ -z "$DOCKER_HOST" || "$DOCKER_HOST" == "unix:///var/run/docker.sock" ]]; then
    p10k segment -i ' ' -b 8 -f 15 -t self
  fi
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
