set -e

echo "Installing PHP..."

brew tap ezzatron/brew-php
brew tap homebrew/homebrew-php

brew install brew-php

brew php install php53 php53-intl
brew php install php54 php54-intl
brew php install php55 php55-intl
brew php install php56 php56-intl
brew php install php70 php70-intl
brew php install php71 php71-intl
brew php install php72 php72-intl

brew php link php72

brew php install composer

PHP_ETC_PATH="$(brew --prefix)/etc/php"

echo "date.timezone = 'Australia/Brisbane'" > "$PHP_ETC_PATH/php.ini"
echo "phar.readonly = 0" >> "$PHP_ETC_PATH/php.ini"

pushd "$PHP_ETC_PATH/5.3" > /dev/null
ln -fs ../php.ini
popd > /dev/null

pushd "$PHP_ETC_PATH/5.4" > /dev/null
ln -fs ../php.ini
popd > /dev/null

pushd "$PHP_ETC_PATH/5.5" > /dev/null
ln -fs ../php.ini
popd > /dev/null

pushd "$PHP_ETC_PATH/5.6" > /dev/null
ln -fs ../php.ini
popd > /dev/null

pushd "$PHP_ETC_PATH/7.0" > /dev/null
ln -fs ../php.ini
popd > /dev/null

pushd "$PHP_ETC_PATH/7.1" > /dev/null
ln -fs ../php.ini
popd > /dev/null

pushd "$PHP_ETC_PATH/7.2" > /dev/null
ln -fs ../php.ini
popd > /dev/null
