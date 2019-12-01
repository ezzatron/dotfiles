set -e

echo "Configuring PHP..."

PHP_ETC_PATH="$(brew --prefix)/etc/php"
echo "date.timezone = 'Australia/Brisbane'" > "$PHP_ETC_PATH/php.ini"
echo "phar.readonly = 0" >> "$PHP_ETC_PATH/php.ini"

pushd "$PHP_ETC_PATH/7.4" > /dev/null
ln -fs ../php.ini
popd > /dev/null
