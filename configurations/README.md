# Index

For more informations : [Index](https://github.com/damln/AdminTools)

## GIT Http auth OSX

Configure :

	sudo mv git-credential-osxkeychain `dirname \`which git\``
    chmod u+x `which git-credential-osxkeychain`
    git config --global credential.helper osxkeychain

Pull a repo :

    cd /my/http/auth/git/path

    git pull

Now, enter the Password and store it in OSX keychain.

## SSH with public key

On your server

	sudo cp ./sshd_config.txt /etc/ssh/sshd_config

On your client

	cat ~/.ssh/id_dsa.pub | ssh user@machine "cat - >> ~/.ssh/authorized_keys"


## Amazon EC2 ssh (Ubuntu)

Connect with .pem key :

    ssh -i my.pem ubuntu@your_amazon_host_ip

    sudo passwd ubuntu # set a password

    sudo sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

You can now connect without .pem key on your Amazon EC2 instance.
