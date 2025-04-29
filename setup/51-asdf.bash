set -e

echo "Installing asdf plugins..."

asdf plugin add java https://github.com/halcyon/asdf-java.git
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add protoc https://github.com/paxosglobal/asdf-protoc.git
