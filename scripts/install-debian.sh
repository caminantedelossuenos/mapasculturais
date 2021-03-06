#!/bin/bash
echo ''
echo "MAPAS CULTURAIS: Debian-based distributions install script"
echo ''
echo 'Please use this script as a document for installing MAPAS CULTURAIS dependencies in your distribution:'
echo ''
echo 'git ssh openssh-server curl apache2 php5 php5-gd php5-cli php5-json php5-curl php5-pgsql php-apc postgresql postgresql-contrib postgis postgresql-9.3-postgis-2.1 postgresql-9.3-postgis-2.1-scripts'
echo ''1
echo -n "MAPAS CULTURAIS: Press Enter to continue, or Ctrl-C to abort."
read enter

echo 'MAPASCULTURAIS: The installer will add PostgreSQL APT repositories:'
echo ''
sudo ./apt.postgresql.org.sh

echo "MAPAS CULTURAIS: Installing Dependencies. Please confirm."
echo ''

sudo apt-get install git ssh openssh-server curl apache2 php5 php5-gd php5-cli php5-json php5-curl php5-pgsql php-apc postgresql postgresql-contrib postgis postgresql-9.3-postgis-2.1 postgresql-9.3-postgis-2.1-scripts

echo "MAPAS CULTURAIS: Checking Composer Dependency Manager for PHP"
if ! type composer.phar 2>/dev/null; then
    echo "MAPAS CULTURAIS: Installing Composer"
    curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer.phar
fi

echo "MAPAS CULTURAIS: Getting Dependencies using Composer"
composer.phar --working-dir=../src/protected install --prefer-dist

echo "MAPAS CULTURAIS: Setting up mapasculturais PostgreSQL Database"
./install.sh


echo "MAPAS CULTURAIS: Please edit src/protected/application/conf/config.php"
cp ../src/protected/application/conf/config.template.php ../src/protected/application/conf/config.php
echo ""

echo "MAPAS CULTURAIS: Running initial-configuration.sh"
./initial-configuration.sh
echo ""

echo "MAPAS CULTURAIS: Install Finished"
echo ""

echo "You can test the application running PHP's built-in web server issuing command
php -S 0.0.0.0:8000 -t ../src ../src/router.php
And accessing http://localhost:8000
"