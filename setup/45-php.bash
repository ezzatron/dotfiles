set -e

echo "Configuring PHP..."

PHP_INI_SCAN_DIR="$(php --ini | grep "conf\.d$" | sed "s/.*: \//\//")"

echo "date.timezone = 'Australia/Brisbane'" > "$PHP_INI_SCAN_DIR/timezone.ini"
echo "phar.readonly = 0" >> "$PHP_INI_SCAN_DIR/phar.ini"
