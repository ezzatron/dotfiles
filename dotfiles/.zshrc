export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="mh"
CASE_SENSITIVE="true"
DISABLE_UPDATE_PROMPT=true
ZSH_CUSTOM="$HOME/zsh"

plugins=(brew colored-man-pages colorize command-not-found common-aliases composer custom docker git history history-substring-search node npm osx screen sublime z)

source $ZSH/oh-my-zsh.sh
source "$HOME/.iterm2_shell_integration.zsh"
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='subl -n -w'
fi

unsetopt share_history

if [ "$TERM_PROGRAM" = "Apple_Terminal" ]; then
    setopt combiningchars
fi

PROMPT_DATE="[%{$fg_bold[black]%}%T%{$reset_color%}]"
RPROMPT="$RPROMPT$PROMPT_DATE"

ssh-add -A 2>/dev/null

autoload -U compinit && compinit
autoload -U bashcompinit && bashcompinit
eval "$(grit shell-integration)"
