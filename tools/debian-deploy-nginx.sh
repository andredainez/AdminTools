#!/bin/bash

if [ "$USER" != "root" ];then
    echo "Please start the script with ROOT"
    exit
fi

# Add good paquet
line="deb http://ppa.launchpad.net/nginx/stable/ubuntu $(lsb_release -cs) main"
previous=$(grep "$line" /etc/apt/sources.list)

if [[ "$previous" == "" ]]; then
    echo "$line" >> /etc/apt/sources.list
fi

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C
apt-get clean
apt-get autoclean
apt-get update

echo "== Installing:"
apt-get -y remove nginx-common
apt-get -y --force-yes remove --purge nginx

apt-get -y install php5-common php5-dev php5-mysql php5-sqlite php5-tidy php5-xmlrpc php5-xsl php5-cgi php5-mcrypt php5-curl php5-gd php5-memcache php5-mhash php5-pspell php5-snmp php5-sqlite libmagick9-dev php5-cli

apt-get -y install nginx

echo '
#!/bin/bash
BIND=127.0.0.1:9000
USER=www-data
PHP_FCGI_CHILDREN=15
PHP_FCGI_MAX_REQUESTS=1000

PHP_CGI=/usr/bin/php-cgi
PHP_CGI_NAME=`basename $PHP_CGI`
PHP_CGI_ARGS="- USER=$USER PATH=/usr/bin PHP_FCGI_CHILDREN=$PHP_FCGI_CHILDREN PHP_FCGI_MAX_REQUESTS=$PHP_FCGI_MAX_REQUESTS $PHP_CGI -b $BIND"
RETVAL=0

start() {
      echo -n "Starting PHP FastCGI: "
      start-stop-daemon --quiet --start --background --chuid "$USER" --exec /usr/bin/env -- $PHP_CGI_ARGS
      RETVAL=$?
      echo "$PHP_CGI_NAME."
}
stop() {
      echo -n "Stopping PHP FastCGI: "
      killall -q -w -u $USER $PHP_CGI
      RETVAL=$?
      echo "$PHP_CGI_NAME."
}

case "$1" in
    start)
      start
  ;;
    stop)
      stop
  ;;
    restart)
      stop
      start
  ;;
    *)
      echo "Usage: php-fastcgi {start|stop|restart}"
      exit 1
  ;;
esac
exit $RETVAL

' > /etc/init.d/php-fastcgi

rm /etc/nginx/sites-enabled/*

echo "== Cleaning:"
apt-get -y autoremove
apt-get -y autoclean
apt-get -y clean

echo "== Stop Service:"

/etc/init.d/php-fastcgi stop
/etc/init.d/nginx stop
/etc/init.d/bind9 stop
/etc/init.d/apache2 stop
/etc/init.d/mysql stop
/etc/init.d/php5-cgi stop
/etc/init.d/php5-fpm stop

killall php5-cgi
killall php5-fpm

update-rc.d -f bind9 remove
update-rc.d -f apache2 remove

chmod 755 /etc/init.d/php-fastcgi

if [[ -f "./nginx.conf" ]]; then
    cp ./nginx.conf /etc/nginx/nginx.conf
fi

bash /etc/init.d/php-fastcgi stop
bash /etc/init.d/nginx restart

echo "
NGINX Installed and running.
"
