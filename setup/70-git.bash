set -e

echo "Configuring Git..."
"$HOME/dotfiles/generators/git-config"

echo "Configuring Grit..."
"$HOME/dotfiles/generators/grit-config"
