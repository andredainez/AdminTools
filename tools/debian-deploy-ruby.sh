#!/bin/bash

if [[ "$USER" == "root" ]]; then
    echo "Not root here."
    exit
fi

sudo apt-get -y install gcc
sudo apt-get -y install bzip2
sudo apt-get -y install make
sudo apt-get -y install build-essential bison openssl libreadline6 libreadline6-dev
sudo apt-get -y install git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev


rm -rf ~/.rvm

curl -L get.rvm.io | bash -s stable

source ~/.rvm/scripts/rvm
source ~/.bashrc
source ~/.profile

rvm pkg install readline
rvm pkg install iconv
rvm pkg install zlib
rvm pkg install openssl
rvm pkg install autoconf
rvm pkg install curl
rvm pkg install gettext
rvm pkg install glib
rvm pkg install libxml2
rvm pkg install libxslt
rvm pkg install libyaml
rvm pkg install llvm
rvm pkg install mono
rvm pkg install ncurses
rvm pkg install pkgconfig

rvm reload
rvm install 2.0

source ~/.rvm/scripts/rvm
source ~/.bashrc
source ~/.profile

rvm gemset use global
gem install bundler
gem install bundle

rvm --default use 2.0
