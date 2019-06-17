set -e

echo "Creating directories..."

[ -e "$HOME/bin" ] || mkdir -p "$HOME/bin"
[ -e "$HOME/go" ] || mkdir -p "$HOME/go"
