# Network

Set DNS :
    
    netsh int ip set dns "local area connection" static 8.8.8.8 primary 
    
Set IP , Mask and Gateway :

    netsh int ip set address "local area connection" static 192.168.1.10 255.255.255.0 192.168.1.1
