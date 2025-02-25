set -e

echo "Installing asdf plugins..."

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add protoc https://github.com/paxosglobal/asdf-protoc.git

echo "Installing asdf tools..."

asdf install nodejs latest
asdf set --home nodejs system

asdf install protoc latest
asdf set --home protoc system
