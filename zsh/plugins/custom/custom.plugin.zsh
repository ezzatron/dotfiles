HUB_BINARY="$(which hub)"

git() {
    if [[ "$1" == "clone" && $# -eq 2 ]]; then
        __git-clone "$2"
    else
        "$HUB_BINARY" "$@"
    fi

    return $?
}

__git-clone() {
    local rpath="$GIT_PATH/$(basename "$1" .git)"

    if [[ -e "$rpath" ]]; then
        cd "$rpath"
    else
        "$HUB_BINARY" clone "$1" "$rpath" && cd "$rpath"
    fi

    return $?
}

hub() {
    if [[ "$1" == "clone" && $# -eq 2 ]]; then
        __hub-clone "$2"
    else
        "$HUB_BINARY" "$@"
    fi

    return $?
}

__hub-clone() {
    local rpath="$GITHUB_PATH/$1"

    if [[ -e "$rpath" ]]; then
        cd "$rpath"
    else
        "$HUB_BINARY" clone -p "$1" "$rpath" && cd "$rpath"
    fi

    return $?
}
