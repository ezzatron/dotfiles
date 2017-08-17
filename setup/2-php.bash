set -e

echo "Installing PHP..."

brew tap homebrew/homebrew-php

brew unlink php53 || true
brew unlink php53-intl || true
brew unlink php54 || true
brew unlink php54-intl || true
brew unlink php55 || true
brew unlink php55-intl || true
brew unlink php56 || true
brew unlink php56-intl || true
brew unlink php70 || true
brew unlink php70-intl || true
brew unlink php71 || true
brew unlink php71-intl || true
brew unlink php72 || true
brew unlink php72-intl || true
brew unlink composer || true

brew install php53 --without-apache
brew link --overwrite php53
brew install \
    php53-intl
brew unlink php53

brew install php54 --without-apache
brew link --overwrite php54
brew install \
    php54-intl
brew unlink php54

brew install php55 --without-apache
brew link --overwrite php55
brew install \
    php55-intl
brew unlink php55

brew install php56 --without-apache --with-phpdbg
brew link --overwrite php56
brew install \
    php56-intl
brew unlink php56

brew install php70 --without-apache --with-phpdbg
brew link --overwrite php70
brew install \
    php70-intl
brew unlink php70

brew install php72 --without-apache --with-phpdbg
brew link --overwrite php72
brew install \
    php72-intl

brew install php71 --without-apache --with-phpdbg
brew link --overwrite php71
brew install \
    php71-intl

brew install composer
brew link --overwrite composer

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
