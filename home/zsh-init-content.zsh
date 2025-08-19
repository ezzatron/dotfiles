# include VSCode shell integration
# see https://code.visualstudio.com/docs/terminal/shell-integration
[[ "$TERM_PROGRAM" == "vscode" ]] && source "$(code --locate-shell-integration-path zsh)"

# include Grit completions
# see https://github.com/jmalloc/grit#:~:text=eval%20%22%24(grit-,shell%2Dintegration,-)%22
eval "$(grit shell-integration)"
