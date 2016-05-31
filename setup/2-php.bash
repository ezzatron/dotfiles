echo "Installing PHP..."

brew install \
    homebrew/php/php53 --with-phpdbg \
    homebrew/php/php53-intl
    homebrew/php/php54 --with-phpdbg \
    homebrew/php/php54-intl
    homebrew/php/php55 --with-phpdbg \
    homebrew/php/php55-intl
    homebrew/php/php56 --with-phpdbg \
    homebrew/php/php56-intl
    homebrew/php/php70 --with-phpdbg \
    homebrew/php/php70-intl

PHP_ETC_PATH="$(brew --prefix)/etc/php"

echo "date.timezone = 'Australia/Brisbane'" >> "$PHP_ETC_PATH/php.ini"
echo "phar.readonly = 0" >> "$PHP_ETC_PATH/php.ini"

pushd "$PHP_ETC_PATH/5.3" > /dev/null
ln -s ../php.ini
popd > /dev/null

pushd "$PHP_ETC_PATH/5.4" > /dev/null
ln -s ../php.ini
popd > /dev/null

pushd "$PHP_ETC_PATH/5.5" > /dev/null
ln -s ../php.ini
popd > /dev/null

pushd "$PHP_ETC_PATH/5.6" > /dev/null
ln -s ../php.ini
popd > /dev/null

pushd "$PHP_ETC_PATH/7.0" > /dev/null
ln -s ../php.ini
popd > /dev/null

if [[ -f "$HOME/bin/composer" ]]; then
    echo "Composer already installed."
else
    echo "Installing Composer..."
    curl -fsSL "https://getcomposer.org/download/1.0.0/composer.phar" > "$HOME/bin/composer"
fi

echo "Updating Composer..."
"$HOME/bin/composer" selfupdate
