autoload -U bashcompinit && bashcompinit

source "$HOME/.functions.zsh"
source-if-exists "$HOME/.functions.workfiles.zsh"

source-if-exists "$HOME/.cache/p10k-instant-prompt-${(%):-%n}.zsh"
source-if-exists "$(brew --prefix)/etc/profile.d/z.sh"
source-if-exists "$HOME/.zprezto/init.zsh"
source-if-exists "$HOME/.iterm2_shell_integration.zsh"
source-if-exists "$HOME/.travis/travis.sh"
source-if-exists "$HOME/.p10k.zsh"

eval "$(grit shell-integration)"

ssh-add -A 2>/dev/null

setopt clobber
unsetopt autocd
unsetopt correct

export WORDCHARS="_"
