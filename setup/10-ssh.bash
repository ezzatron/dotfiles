set -e

if [ -f "$HOME/.ssh/id_rsa" ]; then
    echo "SSH key already exists."
else
    echo "Fetching SSH key from 1Password..."

    mkdir -p "$HOME/.ssh"
    op get item --account=my SSH | jq --raw-output .details.notesPlain \
        > "$HOME/.ssh/id_rsa"
    chmod 600 "$HOME/.ssh/id_rsa"
fi

echo "Adding SSH key to keychain..."

ssh-add -K "$HOME/.ssh/id_rsa"

echo "Switching dotfiles repo to SSH..."

pushd "$HOME/dotfiles" > /dev/null
git remote set-url origin "$(git config --get remote.origin.url | sed 's/https:\/\/github.com\//git@github.com:/')"
popd > /dev/null
