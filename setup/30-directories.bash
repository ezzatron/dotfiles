set -e

echo "Creating directories..."

[ -e "$HOME/.z" ] || mkdir -p "$HOME/.z"
[ -e "$HOME/bin" ] || mkdir -p "$HOME/bin"
[ -e "$HOME/go" ] || mkdir -p "$HOME/go"
