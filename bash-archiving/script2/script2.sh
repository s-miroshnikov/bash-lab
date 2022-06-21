#!/bin/bash

pid_file="/var/run/script2.pid"

# ensure only one instance of script is running
if [ -f "$pid_file" ] && ps -p "$(cat "$pid_file")" > /dev/null
then
    # another instance of this script is running
    exit
fi

# write script's PID to pid-file
printf "%s\n" "$$" > "$pid_file"
maxfiles=3
maxbytes=50

while true
do

set -o allexport
source /usr/local/bin/.env2
set +o allexport
# find count of files
counterf=$(find /local/backups/ -type f | wc -l)
# find size of the folder in bytes
counterb=$(du -s /local/backups/ | cut -f1)
if ((counterf > maxfiles))
then
echo "Number of files is $counterf" | mailx -Ssendwait -s "Number of files more than $maxfiles" root@db
fi
if ((counterb > maxbytes))
then
echo "Size of folder is $counterb" | mailx -Ssendwait -s "Size of folder exceeded" root@db
fi
sleep 60
done