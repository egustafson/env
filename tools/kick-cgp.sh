sudo apt-get update
sudo apt-get install -y collectd lighttpd php5 php5-cgi
sudo lighttpd-enable-mod fastcgi
sudo lighttpd-enable-mod fastcgi-php
sudo service lighttpd force-reload

cd /var/www
sudo git clone git://github.com/egustafson/CGP.git cgp
