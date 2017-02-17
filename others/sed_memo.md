Add "A" to the end of the line, where lines contain "$ext" :
	
	sed "/$ext/ s/.*/& A/"

Remove space in the start and teh end of each lines :

	sed 's/^[ \t]*//;s/[ \t]*$//'

Remove lines with the word "awk" :
	
	sed '/awk/d' file.txt

Remove blank lines :
	
	sed '/^$/d' file.txt

Remove blank lines and commented lines :
	
	sed -i '/^$/d;/^#/d' file.txt

Comment line containing "deux" :
	
	sed '/deux/ s/^/#/'

Get the IP address of a line :
	
	sed "s/..* \([0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}\)..*/\1/"

Convert from unix to dos :
	
	sed 's/$/\r/g' file.txt

Grep Email from a file :
	
	grep -oe '\w*.\w*@\w*.\w*.\w\+' file.txt | sort -u

Get SSH attacks :
	
	grep -i 'authentication failure' /var/log/messages | awk '{ print $13 }' | cut -b7- | sort | uniq -c

Get the second ocurence of lines containing "open" :
	
	awk '/open/{print $2}'

