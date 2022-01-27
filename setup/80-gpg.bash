set -e

echo "Configuring GPG..."

gpg --batch --import <(op document get --account my --vault Personal "Primary GPG Key") &>/dev/null
gpg --import-ownertrust "$HOME/.gpg-ownertrust"

echo "pinentry-program $(brew --prefix)/bin/pinentry-mac
default-cache-ttl 43200 # 12 hours" > "$HOME/.gnupg/gpg-agent.conf"

gpgconf --kill gpg-agent
