# Index

- [See configurations](https://github.com/damln/AdminTools/tree/master/configurations)
- [See tools](https://github.com/damln/AdminTools/tree/master/tools)

## Debian / Ubuntu

Every admin / dev have his own deployment system. This are some basics files to inspire you :)

Feel free to fork, update, and contribute.

Cheers.

### First commands

    sudo apt-get install git
    ssh-keygen
    git clone git://github.com/damln/AdminTools.git

### Clean the Debian

	bash ./tools/debian-cleaner.sh

### Nginx

This will install NGinx with PHP5 and FastCGI.

    bash ./tools/debian-deploy-nginx.sh

If you want MYSQL :

    apt-get install mysql-server mysql-client

### MongoDB

    bash ./tools/debian-deploy-mongodb.sh

### Ruby

	bash ./tools/debian-deploy-ruby.sh
	
	# Press 'q' when prompt

### Redis

    wget http://redis.googlecode.com/files/redis-2.4.13.tar.gz
    tar xzf redis-2.4.13.tar.gz
    cd redis-2.4.13

    make

    sudo ln -s $(pwd)/src/redis-server /usr/bin/redis-server
    sudo ln -s $(pwd)/src/redis-cli /usr/bin/redis-cli


### File recover

	brew install foremost
	
	# OR
	
	sudo apt-get install foremost
	
	foremost -a -w -i /dev/sda1 -o ./output_dir
	
# Other
## Local SMTP server for debug

    sudo python -m smtpd -n -c DebuggingServer localhost:25

## Local HTTP server

    python -m SimpleHTTPServer 8080

## IP things

My ip :

	curl -s checkip.dyndns.org | grep -Eo '[0-9\.]+'

Google DNS :

	8.8.8.8
	8.8.4.4

OpenDNS :

	208.67.222.222
	208.67.220.222

