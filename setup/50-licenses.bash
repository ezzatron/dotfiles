set -e

echo "Installing licenses..."

SUBLIME_CONFIG_PATH="$HOME/Library/Application Support/Sublime Text 3/Local"

if [ -f "$SUBLIME_CONFIG_PATH/License.sublime_license" ]; then
    echo "Sublime Text license already exists."
else
    echo "Fetching Sublime Text license from 1Password..."
    mkdir -p "$SUBLIME_CONFIG_PATH"
    op get item --account=my 'Sublime Text' | jq --raw-output '.details.sections[]? | select(.title == "") | .fields[]? | select(.t == "license key") | .v' \
        > "$SUBLIME_CONFIG_PATH/License.sublime_license"
fi
