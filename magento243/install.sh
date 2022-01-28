#!/bin/bash 
chmod +x magento-*
unzip magento-ce-*
chmod 777 -R ../magento243
chown root:root ../magento243
mysql -ui95dev -p -e "create database magento243"; 

bin/magento setup:install --base-url=http://localhost/magento243 --db-host=localhost --db-name=magento243 --db-user=i95dev  --db-password=i95dev  --admin-firstname=Azhar --admin-lastname=Shaik --admin-email=azharuddin.shaik@jivainfotech.com  --admin-user=admin --admin-password=i95devteam --search-engine=elasticsearch7 --elasticsearch-host="localhost" --elasticsearch-port=9200

bin/magento module:disable Magento_TwoFactorAuth
php bin/magento setup:store-config:set --base-url="http://magento243.com"
chmod 777 -R ../magento243
chown root:root ../magento243

echo '<VirtualHost *:80>
     ServerAdmin admin@cybr-magento.com
     DocumentRoot /var/www/html/magento243/pub
     ServerName magento243.com
     ServerAlias www.magento243.com

     <Directory /var/www/html/magento243/pub>
        Options +FollowSymlinks
        AllowOverride All
        Require all granted
     </Directory> 


     ErrorLog ${APACHE_LOG_DIR}/error.log
     CustomLog ${APACHE_LOG_DIR}/access.log combined

</VirtualHost>' > /etc/apache2/sites-available/magento243.conf



sudo a2ensite magento243.conf
sudo a2enmod rewrite
service apache2 restart

echo '127.0.0.1 magento243.com' >> /etc/hosts

