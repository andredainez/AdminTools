# UNIX

## Modules

    modinfo [module]    # info on a module
    modprobe -a [module]     # manually load a module
    modprobe -r [module]    # manually unload a module
    modprobe -l    # list kernel modules
    lsmod          # list loaded kernel modules
    
File to put blacklist modules :

	/etc/modprobe.d/blacklist  # liste des m

Some modules :

	blacklist ohci1394  # firewire
    blacklist sdhci_pci # card SD
    blacklist ricoh_mmc # card mmc
    blacklist pcspkr   # mother board speakers
    blacklist rtl8187  # wifi
    blacklist pci_slot  # pci
    blacklist ata_piix # IDE controller, useless if sata
    blacklist r8187b # wifi
    blacklist prism2_usb # wifi
    blacklist rtl8187  # wifi

## Network

Change MAC :

	ifconfig eth0 down
	ifconfig eth0 hw ether 00:11:22:33:44:55
	ifconfig eth0 up

Set IP and mask :

	ifconfig eth0 inet 192.168.1.18 netmask 255.255.255.0

Set default Gateway :

	route add default gw 192.168.1.1

Flush DNS cache :

	sudo /etc/init.d/networking restart # HARD
	sudo /etc/init.d/dns-clean start
	
	sudo killall -SIGHUP dnsmasq

## Users

Add a UNIX user with login : my_login,  and password : my_pass , and the shell MySecureShell :

	useradd -m -s /bin/MySecureShell -p `openssl passwd my_pass` my_login

Completely remove a UNIX user :

	userdel -rf [user login]

Remove a UNIX user password :

	passwd -d [user login]

Disable an user :

	passwd -l [user login]
	
Unable an user :

	passwd -l [user login]

Add a UNIX user to a secondary group :

	usermod -a -G [group] [user login]

## Brightness

levels:  1 8 15 20 29 39 49 59 69
Set a level :

	echo "8" > /proc/acpi/video/VGA1/LCDD/brightness

## Services

Start a service :

	/etc/init.d/a_service start

Stop a service :

	/etc/init.d/a_service stop

Remove a service from boot :

	update-rc.d -f [service name] remove

Put a service on boot :

	update-rc.d [service name] defaults

Somes services :

	cups                 # printers
    hplip       # HP printers
    apmd               #  kernel useless if 'apm' return nothing or "no support"
    lvm      # for logicals volumes
    apport              # send feedbacl to Ubuntu (useless)
    avahi-daemon       # a network deamon, for sharing ressources
    pcmciautils         # pcmcia card
    pcmcia
    dns-clean           # for modems
    bluetooth          # bluetooth
    bluez-utils
    vmware          # vmware products
    nmbd                    # deamon samba
    smbd                     # deamon samba
    pppd-dns            # modem only (not adsl)
    saned               # xsane scanner photo
    usplash             # boot progress bar
    pulseaudio          # ubuntu sound server
    ntpd                # time server
    openntpd            # time server
    portmap            # open the port 111, for printers
    ondemand           # scaling governor CPU
    nfs-common         # file sharing server
    mdadm              # manage RAID
    mdadm-raid              # manage RAID
    laptop-mode     # for bateries
    evms           # for "Enterprise Volumn Management System"
    fetchmail        # email receiver
    inetd    # look to /etc/inetd.conf
    
## CPU

Set CPU power :

	echo 1300000 > /sys/devices/system/cpu/cpufreq/scaling_setspeed

Change CPU manager :

	echo performance/userspace/powersave > /sys/devices/system/cpu/cpufreq/scaling_governor
	
performance : max frequence
powersave : min frequence
userpace : choice the frequence by scaling-set

Get actual CPU speed :

	cat /proc/cpuinfo | grep MHz

## USB problem 

	mkdir /etc/udev/rules.old
	mv /etc/udev/rules.d/* /etc/udev/rules.old
	service udev restart

## Hard Drive

Tools :

	sudo apt-get install mtools
	sudo apt-get install e2fsprogs
	sudo apt-get install qemu
	sudo apt-get install dosfstools

Photorec :

	sudo apt-get install testdisk

Rename VFAT :
	
	mlabel -i /dev/sdc6 ::NewName

If problem :

	echo mtools_skip_check=1 >> ~/.mtoolsrc

Rename NTFS :

	ntfslabel /dev/sdc6 NewName

Rename ext3 :

	e2label /dev/sdc6 NewName

or

	tune2fs -L Newname /dev/sdc5

Create a 10G qemu image disk :

	qemu-img create -f vmdk hda.vmdk 10G

Info on disk mount :

	tune2fs -l /dev/sdc6 | grep Max

## Sound

Down volume :

	    amixer -q -c 0 sset Master 1-
Up volume :

    amixer -q -c 0 sset Master 1+

Mute :

    amixer -q -c 0 sset Master mute

Unmute :

    amixer -q -c 0 sset Master unmute
    
Toggle mute/unmute :
    
    amixer -q -c 0 sset Master toggle

## Screen

Tool :
	
	sudo apt-get install screen
	
Start a screen :

	screen -S [screen name]

Detach screen :
	
	Control + a + d

Attach existing screen :

	screen -r [screen name]

List screens :

	screen -ls

Attach an opened screen :

	screen -x [screen name]

Remove "zombies" screens :

	screen -wipe
	
## Various

Apache Bandwidth usage :

	cat /var/log/apache2/access.log | awk '{ SUM += $NF} END { print SUM/1024/1024 " mo" }'

Speed up Gnome :

	echo "gtk-menu-popup-delay = 0" >> ~/.gtkrc-2.0

Capture Streaming Audio :
	
	sudo apt-get install streamripper
	streamripper [URL:PORT] -d [directorty to extract, default=here]

