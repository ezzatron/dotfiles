set -e

echo "Configuring Hub..."

if [[ -z "$GH_USER" ]]; then
    echo "GH_USER not defined."
    exit 1
fi

if [[ -z "$GH_TOKEN" ]]; then
    echo "GH_TOKEN not defined."
    exit 1
fi

mkdir -p "$HOME/.config"
touch "$HOME/.config/hub"

if grep -q github.com "$HOME/.config/hub"; then
  echo "Hub is already configured for github.com"
else
  cat >> "$HOME/.config/hub" <<EOL
github.com:
- user: $GH_USER
  oauth_token: $GH_TOKEN
  protocol: https
EOL
  echo "Added Hub configuration for github.com"
fi


