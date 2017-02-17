# Install a VPN on your Ubuntu Server

Get the script:

    curl -L https://raw.github.com/damln/AdminTools/master/vpn/server-vpn-install.sh > server-vpn-install.sh

Change the user and passwords inside the script:
	
	vi server-vpn-install.sh

Run the script:

	sudo bash server-vpn-install.sh

Choose when prompted `Use an X.509 certificate for this host?`:
	
	yes
	
Choose when prompted `Methods for using a X.509 certificate to authenticate this host`:
	
	create
	
Choose when prompted `Create a self-signed X.509 certificate?` :

	yes
	
# Configure your Mac

Create a new VPN entry:

- System Preferences
- Network
- In left column, "+" (Create a new service)
- Interface  VPN
- VPN Type: L2TP over IPSec
- Service Name: (What you want, example : VPN home)

Configure:

- Configuration : Default
- Server Address: your VPN IP (or hostname)
- Account Name: (the user you put in $VPN_USER)
- Go to: Authentification Settings …
- in "User Authentification", password: (the password your put in $VPN_PASSWORD)
- in "Machine Authentification", Shared Secret: (the password your put in $VPN_PASSWORD)
- OK

Send all traffic:

- in the same page, click on "Advanced…"
- Select: "Send all traffic over VPN connection"
- OK