CASE_SENSITIVE=true

source "$HOME/.functions.zsh"

source-if-exists "$(brew --prefix)/etc/profile.d/z.sh"
source-if-exists "$HOME/.zprezto/init.zsh"
source-if-exists "$HOME/.iterm2_shell_integration.zsh"
source-if-exists "$HOME/.travis/travis.sh"

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='subl -n -w'
fi

unsetopt share_history

if [ "$TERM_PROGRAM" = "Apple_Terminal" ]; then
  setopt combiningchars
fi

ssh-add -A 2>/dev/null

autoload -U compinit && compinit
autoload -U bashcompinit && bashcompinit
eval "$(grit shell-integration)"
