# Index

For more informations : [Index](https://github.com/damln/AdminTools)

## Helpers

### You can use the nginx_on.sh script for activate some website :

    bash ./debian-nginx_on.sh /var/www/my_web_site.com/ on

Or Disable :

    bash ./debian-nginx_on.sh /var/www/my_web_site.com/ off

### Disable all Iptables rules :

    sudo bash ./debian-iptables-stop.sh

### Enable them again :

    sudo bash /etc/init.d/iptables

## Secure data clean
Will fill the folder with 500mo random data:

	bash ./dd.sh /path/to/dead/folder

## Clean useless files

	bash ./clean.sh /path/to/clean
	
## MP3 to CAF

	bash ./osx-mp3-to-caf.sh /path/to/mp3