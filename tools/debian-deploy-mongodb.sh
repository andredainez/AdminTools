#!/bin/bash

if [ "$USER" != "root" ]; then
    echo "Please start the script with ROOT"
    exit
fi

apt-get remove --purge mongodb
apt-get remove mongodb-10gen

apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10

echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' >> /etc/apt/sources.list
echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen ' >> /etc/apt/sources.list

apt-get clean
apt-get autoclean
apt-get update
apt-get install mongodb-10gen

curl -O https://raw.github.com/mongodb/mongo/master/debian/init.d
mv -f ./init.d /etc/init.d/mongodb
chmod 755 /etc/init.d/mongodb

update-rc.d mongodb defaults
/etc/init.d/mongodb restart