HUB_BINARY="$(which hub)"

git() {
    if [[ "$1" == "clone" && $# -eq 2 ]]; then
        _repo-clone "$2"
    else
        "$HUB_BINARY" "$@"
    fi

    return $?
}

_repo-clone() {
    local rpath=""

    if [[ "$1" =~ ^[a-zA-Z0-9_-]+/[a-zA-Z0-9_-]+$ ]]; then
        rpath="$GITHUB_PATH/$1"
    else
        rpath="$GIT_PATH/$(basename "$1" .git)"
    fi

    if [[ -e "$rpath" ]]; then
        cd "$rpath"
    else
        "$HUB_BINARY" clone "$1" "$rpath" && cd "$rpath"
    fi

    return $?
}
