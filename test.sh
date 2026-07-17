#!/bin/sh

user=naresh
port=22
key=/home/naresh/Naresh_prv.pem
serverslist=/home/naresh/serverslist.txt
command="free -h | awk 'NR==2 {print \$7}' | sed 's/Gi//'"
exec > /home/naresh/output.log

while read -r server; do
	echo "Checking on Server:$server"
	memory=$(ssh -n -i "$key" -p "$port" "$user@$server" "$command")
	echo "Server:$server is completed"

	if [ "$memory" < 1 ]; then
		echo "Available memory is less than 10%"
	else
		echo "Available memory is $memory"
	fi
done < "$serverslist"
