# include custom functions
source "$HOME/.functions.zsh"

# include Powerlevel10k instant prompt
# see https://github.com/romkatv/powerlevel10k#instant-prompt
source-if-exists "$HOME/.cache/p10k-instant-prompt-${(%):-%n}.zsh"
# include prezto
# see https://github.com/sorin-ionescu/prezto
source-if-exists "$HOME/.zprezto/init.zsh"
# include iTerm shell integration
# see https://iterm2.com/documentation-shell-integration.html
source-if-exists "$HOME/.iterm2_shell_integration.zsh"
# include Powerlevel10k
# see https://github.com/romkatv/powerlevel10k
source-if-exists "$HOME/.p10k.zsh"

# add completions support for commmands that only support bash (e.g. Grit v1)
autoload -U bashcompinit && bashcompinit

# include fzf
source-if-exists "$HOME/.fzf.zsh"

# include 1Password CLI completions
# see https://developer.1password.com/docs/cli/get-started/#shell-completion
eval "$(op completion zsh)"; compdef _op op
# include Grit completions
# see https://github.com/jmalloc/grit#:~:text=eval%20%22%24(grit-,shell%2Dintegration,-)%22
eval "$(grit shell-integration)"
# include zoxide completions
# see https://github.com/ajeetdsouza/zoxide#installation
eval "$(zoxide init zsh)"

# prevent the "file exists" warning when using shell redirection
setopt clobber
# don't automatically change directory when a command is not found, and a
# matching directory exists
unsetopt autocd
# don't attempt to auto-correct command names, just fail immediately
unsetopt correct

# treat underscores as part of words in the line editor
# this matches the behavior of code editors like VSCode
export WORDCHARS="_"

# check that Touch ID for sudo is still enabled
touchid-sudo-check

# aliases
alias '??=gh copilot suggest -t shell'

# include extension config
setopt nullglob
for FILE in "$HOME/dotfiles/extensions/"*/dotfiles/.zshrc; do
  source "$FILE"
done
unsetopt nullglob
