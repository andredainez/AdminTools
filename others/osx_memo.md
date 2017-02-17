## Stuff

Install pygments :

	sudo easy_install Pygments

Then, alias in bash :

	echo "alias c='pygmentize -O style=monokai -f console256 -g'" >> ~/.bash_profile

## Network

Flush cache :

	sudo dscacheutil -flushcache

Uninstall Mysql (BACKUP FIRST!) :

	sudo rm -rf /usr/local/mysql*
	sudo rm -rf /Library/StartupItems/MySQLCOM

	# in /etc/hostconfig, replace the MSQLCOM entry by :

	MSQLCOM=-NO-

## Google sync less
Sync contact every hour

	defaults write ~/Library/LaunchAgents/com.google.GoogleContactSyncAgent StartInterval -int 3600

## Files
Show hidden fils in Finder :

	defaults write com.apple.finder AppleShowAllFiles -bool true

## Resize images to 50%. For non-retina.

	bash ../tools/osx-resize-50-percent.sh /path/to/*.@2x.png

## Chrome
Open Chrome with a proxy setting :

	open -a '/Applications/Google Chrome.app' --args --proxy-server=localhost:2222

## XAMPP problem
If MYSQL needs .sock :

	sudo ln -s /Applications/XAMPP/xamppfiles/var/mysql/mysql.sock /tmp/mysql.sock

## RVM (Ruby)
[rvm](https://rvm.io/) :

	curl -L https://get.rvm.io | bash -s stable --ruby

	source ~/.bash_profile
	rvm install 2.4
	rvm alias create default 2.4

	rvm use 2.4 --default
	gem install compass
	gem install rb-fsevent
	gem install guard
	gem install guard-shell
	gem install debugger-ruby_core_source
	gem install debugger-linecache

## Homebrew
[homebrew](http://mxcl.github.com/homebrew/) :

	ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"

	brew update
	brew tap homebrew/dupes

	brew install autoconf automake apple-gcc42 libtool pkg-config openssl readline libyaml sqlite libxml2 libxslt libksba

	brew install libksba
	brew install mongodb
	brew install redis
	brew install mysql
	brew install imagemagick
	brew install ffmpeg
	brew install nodejs
	brew install optipng
	brew install libjpeg
	brew install phantomjs

	brew install bash curl git

## MongoDB

Install

    brew install mongodb

Run at startup.

    sudo cp ../configurations/org.mongodb.mongod.plist ~/Library/LaunchAgents/org.mongodb.mongod.plist

    sudo touch /var/log/mongodb.log
    sudo touch /Users/damln/Work/DBS/mongod.conf

    sudo chmod 777 /var/log/mongodb.log
    sudo chmod 755 /Users/damln/Work/DBS/mongod.conf
    chmod 644 ~/Library/LaunchAgents/org.mongodb.mongod.plist

    launchctl unload ~/Library/LaunchAgents/org.mongodb.mongod.plist
    launchctl load ~/Library/LaunchAgents/org.mongodb.mongod.plist

    launchctl stop org.mongodb.mongod.plist
    launchctl start org.mongodb.mongod.plist

    launchctl unload -w /System/Library/LaunchAgents/com.apple.CalendarAgent.plist

## Redis

Install

    brew install redis

Run at startup.

    sudo cp ../configurations/io.redis.redis-server.plist /Library/LaunchDaemons/io.redis.redis-server.plist

    sudo chown root:wheel /Library/LaunchDaemons/io.redis.redis-server.plist

    sudo touch /var/log/redis.log
    sudo chmod 777 /var/log/redis.log

    sudo launchctl unload /Library/LaunchDaemons/io.redis.redis-server.plist
    sudo launchctl load /Library/LaunchDaemons/io.redis.redis-server.plist
    sudo launchctl stop io.redis.redis-server.plist
    sudo launchctl start io.redis.redis-server.plist
