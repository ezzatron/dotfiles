set -e

echo "Configuring Travis CLI..."

TRAVIS_GH_TOKEN="$(op get item --account=my GitHub | jq --raw-output '.details.sections[]? | select(.title == "Tokens") | .fields[]? | select(.t == "Travis") | .v')"

travis login --no-interactive --skip-completion-check --com --github-token "$TRAVIS_GH_TOKEN"
