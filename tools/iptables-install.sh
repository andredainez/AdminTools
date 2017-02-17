ssh_port_tables="$(awk '/#ssh_port/{print $9}' $1)"
ssh_port_config="$(awk '/Port/{print $2}' /etc/ssh/sshd_config)"

# SHECH SSH PORT
if [ "$ssh_port_tables" != "$ssh_port_config" ];then
    echo " ----------------------------------------------------------------"
    echo " => CAUTION! ssh port :"
    echo " => $ssh_port_tables  (iptables) ... and ....  $ssh_port_config (sshd_config)"
    exit
fi

# IPTABLE
if [ -f "$1" ];then
    echo "- Iptables:"
    newname=`echo "$1" | sed 's/.txt//;s/.sh//'`
    cp "$1" "$newname"

    rm /etc/rc*.d/*iptables*
    rm /etc/init.d/*iptables*

    update-rc.d -f "$newname" remove
    rm "/etc/init.d/$newname"
    rm "/etc/init.d/$1"

    cp "$newname" "/etc/init.d/$newname"
    rm "$newname"

    chown root:root "/etc/init.d/$newname"
    chmod 755 "/etc/init.d/$newname"

    update-rc.d -f "$newname" start 15 1 2 3 4 5 . stop 55 0 6 .
fi

# BASHRC
if [ -f "$2" ];then
    echo "- Bashrc:"

    cp "$2" /root/.bashrc
    chown root:root /root/.bashrc
    chmod 755 /root/.bashrc

    cp "$2" "/home/$use/.bashrc"
    chown "$use":"$use" "/home/$use/.bashrc"
    chmod 755 "/home/$use/.bashrc"

    source ~/.bashrc

fi