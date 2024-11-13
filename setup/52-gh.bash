set -e

if gh auth status &>/dev/null; then
  echo "Already signed in to the GitHub CLI."
else
  echo "Signing in to the GitHub CLI..."
  gh auth login --web --skip-ssh-key --hostname github.com --git-protocol ssh
fi
