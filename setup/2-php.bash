set -e

echo "Installing PHP..."

brew tap ezzatron/brew-php

brew install brew-php
brew php install php
brew php link php
brew php install composer

PHP_ETC_PATH="$(brew --prefix)/etc/php"

echo "date.timezone = 'Australia/Brisbane'" > "$PHP_ETC_PATH/php.ini"
echo "phar.readonly = 0" >> "$PHP_ETC_PATH/php.ini"

pushd "$PHP_ETC_PATH/7.3" > /dev/null
ln -fs ../php.ini
popd > /dev/null
