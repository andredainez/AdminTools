#!/bin/bash

if [ "$USER" != "root" ]; then
    echo "Please start the script with ROOT"
    exit
fi



# SUDO USER
echo " ----------------------------------------------------------------"
echo " actuality:"
echo " $USER "
echo " => Please enter the futur 'sudo' USER name:"
read use

# CLEAN
echo "" > errors-deploiement.log
echo " ------------------------------------- "
echo " Cleaning Debian And Ubuntu Server :"

echo "- Stop all services:"
/etc/init.d/openntpd stop >/dev/null 2>>errors-deploiement.log
/etc/init.d/ntp stop >/dev/null 2>>errors-deploiement.log
/etc/init.d/portmap stop >/dev/null 2>>errors-deploiement.log
/etc/init.d/nfs-common stop >/dev/null 2>>errors-deploiement.log
/etc/init.d/inetd stop >/dev/null 2>>errors-deploiement.log
/etc/init.d/openbsd-inetd stop >/dev/null 2>>errors-deploiement.log
/etc/init.d/exim4 stop >/dev/null 2>>errors-deploiement.log
/etc/init.d/fam stop >/dev/null 2>>errors-deploiement.log
/etc/init.d/atd stop >/dev/null 2>>errors-deploiement.log
/etc/init.d/proftpd stop >/dev/null 2>>errors-deploiement.log
/etc/init.d/mysql stop >/dev/null 2>>errors-deploiement.log
/etc/init.d/bind9 stop >/dev/null 2>>errors-deploiement.log
/etc/init.d/mdadm stop >/dev/null 2>>errors-deploiement.log
/etc/init.d/fail2ban stop >/dev/null 2>>errors-deploiement.log
/etc/init.d/rkhunter stop >/dev/null 2>>errors-deploiement.log
/etc/init.d/postfix stop >/dev/null 2>>errors-deploiement.log
/etc/init.d/mysecureshell stop >/dev/null 2>>errors-deploiement.log
/etc/init.d/apache2 stop >/dev/null 2>errors-deploiement.log
/etc/init.d/anacron stop >/dev/null 2>>errors-deploiement.log
/etc/init.d/dns-clean stop >/dev/null 2>>errors-deploiement.log
/etc/init.d/pppd-dns stop >/dev/null 2>>errors-deploiement.log
/etc/init.d/nmbd stop >/dev/null 2>>errors-deploiement.log
/etc/init.d/smbd stop >/dev/null 2>>errors-deploiement.log
/etc/init.d/samba stop >/dev/null 2>>errors-deploiement.log
/etc/init.d/apmd stop >/dev/null 2>>errors-deploiement.log
/etc/init.d/nginx stop >/dev/null 2>>errors-deploiement.log
/etc/init.d/php5-fpm stop >/dev/null 2>>errors-deploiement.log

echo "- Remove services at startup:"
update-rc.d -f openntpd remove >/dev/null 2>>errors-deploiement.log
update-rc.d -f ntp remove >/dev/null 2>>errors-deploiement.log
update-rc.d -f portmap remove >/dev/null 2>>errors-deploiement.log
update-rc.d -f nfs-common remove >/dev/null 2>>errors-deploiement.log
update-rc.d -f inetd remove >/dev/null 2>>errors-deploiement.log
update-rc.d -f openbsd-inetd remove >/dev/null 2>>errors-deploiement.log
update-rc.d -f exim4 remove >/dev/null 2>>errors-deploiement.log
update-rc.d -f fam remove >/dev/null 2>>errors-deploiement.log
update-rc.d -f atd remove >/dev/null 2>>errors-deploiement.log
update-rc.d -f proftpd remove >/dev/null 2>>errors-deploiement.log
update-rc.d -f mysql remove >/dev/null 2>>errors-deploiement.log
update-rc.d -f bind9 remove >/dev/null 2>>errors-deploiement.log
update-rc.d -f mdadm remove >/dev/null 2>>errors-deploiement.log
update-rc.d -f fail2ban remove >/dev/null 2>>errors-deploiement.log
update-rc.d -f rkhunter remove >/dev/null 2>>errors-deploiement.log
update-rc.d -f postfix remove >/dev/null 2>>errors-deploiement.log
update-rc.d -f mysecureshell remove >/dev/null 2>>errors-deploiement.log
update-rc.d -f apache2 remove >/dev/null 2>>errors-deploiement.log
update-rc.d -f mongodb remove >/dev/null 2>>errors-deploiement.log
update-rc.d -f anacron remove >/dev/null 2>>errors-deploiement.log
update-rc.d -f dns-clean remove >/dev/null 2>>errors-deploiement.log
update-rc.d -f pppd-dns remove >/dev/null 2>>errors-deploiement.log
update-rc.d -f nmbd remove >/dev/null 2>>errors-deploiement.log
update-rc.d -f smbd remove >/dev/null 2>>errors-deploiement.log
update-rc.d -f samba remove >/dev/null 2>>errors-deploiement.log
update-rc.d -f apmd remove >/dev/null 2>>errors-deploiement.log
update-rc.d -f silcd remove >/dev/null 2>>errors-deploiement.log
update-rc.d -f nginx remove >/dev/null 2>>errors-deploiement.log
update-rc.d -f php5-fpm remove >/dev/null 2>>errors-deploiement.log

echo "- Purge software:"
apt-get autoremove
apt-get autoclean
apt-get clean
apt-get update

apt-get -y purge ppp
apt-get -y purge openntpd
apt-get -y purge ntpdate
apt-get -y purge ntp
apt-get -y purge portmap
apt-get -y purge exim4
apt-get -y purge fam
apt-get -y purge proftpd
apt-get -y purge mysql-server
apt-get -y purge apache2*
apt-get -y purge mongodb*
apt-get -y purge anacron
apt-get -y purge samba*
apt-get -y purge silc
apt-get -y purge silcd
apt-get -y purge php5
apt-get -y purge php5-*
apt-get -y purge nginx

# REMOVE / BACKUP MYSQL DATABASES
echo "- Removing / Backup database:"
date=$(date '+%Y-%m-%d-%I-%M-%S')
dir_backup=/home/"$use"/backup_mysql/"$date"
mkdir -p "$dir_backup"
cp -R /var/lib/mysql "$dir_backup"
chown -R "$use" "$dir_backup"
chmod -R 700 "$dir_backup"
rm -rf /var/lib/mysql


echo "- Fix LANG to US:"
locale-gen en_US.UTF-8
/usr/sbin/update-locale LANG=en_US.UTF-8

update-rc.d -f ssh start 30 1 2 3 4 5 . stop 30 0 6 .

apt-get -y install make
apt-get -y install gcc
apt-get -y install build-essential bison openssl libreadline6 libreadline6-dev
apt-get -y install sudo
apt-get -y install curl
apt-get -y install htop
apt-get -y install aptitude
apt-get -y install bzip2
apt-get -y install screen
apt-get -y install vim
apt-get -y install git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev

echo "- Secure software:"
chmod 750 /usr/bin/gcc*
chmod 750 /usr/bin/make
chmod 750 /usr/bin/apt-*
chmod 750 /usr/bin/aptitude*
chmod 750 /usr/bin/dpkg*

echo "- Configure sudo:"
echo "
Defaults	env_reset
%sudo	ALL=(ALL) ALL
" > /etc/sudoers
groupadd sudo
gpasswd -a $use sudo

echo "- Remove apache/nginx sites-enabled:"
rm /etc/apache2/sites-enabled/*
rm /etc/nginx/sites-enabled/*

mkdir -p /var/www/
mkdir -p "/home/$use/www"
echo "" > /var/www/index.html

echo "- Cleaning the system:"
apt-get -y autoremove
apt-get -y autoclean
apt-get -y clean
apt-get -y update
apt-get -y upgrade

echo "- Restarting ssh"
echo "000000000000000000000000000000000000000000000000000000"

/etc/init.d/ssh restart
