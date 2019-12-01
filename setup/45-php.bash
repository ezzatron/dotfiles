set -e

echo "Configuring PHP..."

PHP_ETC_PATH="$(brew --prefix)/etc/php"

for VERSION_PATH in "$PHP_ETC_PATH"/*; do
  if [ -d "$VERSION_PATH/conf.d" ]; then
    echo "date.timezone = 'Australia/Brisbane'" > "$VERSION_PATH/conf.d/timezone.ini"
    echo "phar.readonly = 0" > "$VERSION_PATH/conf.d/phar.ini"
  fi
done
