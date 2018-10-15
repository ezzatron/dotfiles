set -e

echo "Installing PHP..."

brew tap ezzatron/brew-php

brew install brew-php

brew php install php@7.0
brew php install php@7.1
brew php install php

brew php link php

brew php install composer

PHP_ETC_PATH="$(brew --prefix)/etc/php"

echo "date.timezone = 'Australia/Brisbane'" > "$PHP_ETC_PATH/php.ini"
echo "phar.readonly = 0" >> "$PHP_ETC_PATH/php.ini"

pushd "$PHP_ETC_PATH/7.0" > /dev/null
ln -fs ../php.ini
popd > /dev/null

pushd "$PHP_ETC_PATH/7.1" > /dev/null
ln -fs ../php.ini
popd > /dev/null

pushd "$PHP_ETC_PATH/7.2" > /dev/null
ln -fs ../php.ini
popd > /dev/null
