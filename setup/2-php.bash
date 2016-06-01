set -e

echo "Installing PHP..."

brew tap homebrew/homebrew-php

brew unlink \
    php53 \
    php54 \
    php55 \
    php56 \
    php70 \
    || true

brew install php53
brew link --overwrite php53
brew install \
    php53-intl
brew unlink php53

brew install php54
brew link --overwrite php54
brew install \
    php54-intl
brew unlink php54

brew install php55
brew link --overwrite php55
brew install \
    php55-intl
brew unlink php55

brew install php56 --with-phpdbg
brew link --overwrite php56
brew install \
    php56-intl
brew unlink php56

brew install php70 --with-phpdbg
brew link --overwrite php70
brew install \
    php70-intl

brew install \
    php53-intl \
    php54-intl \
    php55-intl \
    php56-intl \
    php70-intl

brew install composer

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
