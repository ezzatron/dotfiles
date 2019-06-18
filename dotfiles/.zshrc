autoload -U bashcompinit && bashcompinit

source "$HOME/.functions.zsh"

source-if-exists "$(brew --prefix)/etc/profile.d/z.sh"
source-if-exists "$HOME/.zprezto/init.zsh"
source-if-exists "$HOME/.iterm2_shell_integration.zsh"
source-if-exists "$HOME/.travis/travis.sh"

eval "$(grit shell-integration)"

setopt clobber
