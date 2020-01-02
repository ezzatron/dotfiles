set -e

echo "Configuring Hub..."

if [[ -z "$GITHUB_USER" ]]; then
    echo "GITHUB_USER not defined."
    exit 1
fi

if [[ -z "$GITHUB_TOKEN" ]]; then
    echo "GITHUB_TOKEN not defined."
    exit 1
fi

mkdir -p "$HOME/.config"
touch "$HOME/.config/hub"

if grep -q github.com "$HOME/.config/hub"; then
  echo "Hub is already configured for github.com"
else
  cat >> "$HOME/.config/hub" <<EOL
github.com:
- user: $GITHUB_USER
  oauth_token: $GITHUB_TOKEN
  protocol: https
EOL
  echo "Added Hub configuration for github.com"
fi


