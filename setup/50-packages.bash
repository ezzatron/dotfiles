set -e

echo "Installing packages..."

brew bundle "--file=$HOME/Brewfile"

if [[ -e "$HOME/bin/docker" ]]; then
  echo "Alias from podman to docker already exists."
else
  echo "Aliasing podman to docker..."
  ln -s "$(which podman)" "$HOME/bin/docker"
fi
