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

function iterm2_print_user_vars () {
  iterm2_set_user_var gitSlug "$(git-slug)"
}

function prompt_my_hivecontext() {
  if [[ -n "$HIVE_SWARM_NAME" ]]; then
    p10k segment -i ' ' -b 1 -f 15 -t "$HIVE_SWARM_NAME"
  elif [[ -z "$DOCKER_HOST" || "$DOCKER_HOST" == "unix:///var/run/docker.sock" ]]; then
    p10k segment -i ' ' -b 8 -f 15 -t self
  else
    p10k segment -i ' ' -b 1 -f 15 -t "$DOCKER_HOST"
  fi
}
