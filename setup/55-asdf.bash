set -e

echo "Installing asdf plugins..."

asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add protoc https://github.com/paxosglobal/asdf-protoc.git

echo "Installing asdf tools..."

asdf install nodejs latest
asdf install golang latest
asdf install protoc latest
