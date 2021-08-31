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

function git {
  if [[ "$1" == "checkout" ]]; then
    echo 'ERROR: Use "git switch" or "git restore" instead' >&2
    return 1
  else
    command git "$@"
  fi
}

function source-if-exists () {
  [ -f "$1" ] && source "$1"
}

function touchid-sudo-check () {
  grep -q pam_tid /etc/pam.d/sudo || >&2 echo "WARNING: Touch ID is no longer enabled for sudo. Run touchid-sudo-enable to re-enable."
}

function touchid-sudo-enable () {
  grep -q pam_tid /etc/pam.d/sudo || sudo sed -i.bak $'2i\\\nauth       sufficient     pam_tid.so\n' /etc/pam.d/sudo
}

function iterm2_print_user_vars () {
  iterm2_set_user_var gitSlug "$(git-slug)"
}

function prompt_my_hivecontext() {
  if [[ -n "$HIVE_SWARM_NAME" ]]; then
    p10k segment -i ' ' -b 1 -f 15 -t "$HIVE_SWARM_NAME"
  elif [[ -n "$DOCKER_HOST" && "$DOCKER_HOST" != "unix:///var/run/docker.sock" ]]; then
    p10k segment -i ' ' -b 1 -f 15 -t "$DOCKER_HOST"
  fi
}

function prompt_my_hiveselfcontext() {
  if [[ -z "$HIVE_SWARM_NAME" && (( -z "$DOCKER_HOST" || "$DOCKER_HOST" == "unix:///var/run/docker.sock" )) ]]; then
    p10k segment -i ' ' -b 8 -f 15 -t self
  fi
}
