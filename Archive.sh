#!/bin/bash 

name=""
exclude=""
compression="none"
dest=""
sourcedir="/etc"

function help() {
  echo "Archive script
  Usage example: $0 -s /path/to/sourcedir -d /path/to/destdir -c gz -n "\"*.txt *.sh"\" -x "\"log.txt test.sh"\" -m admin@site.com -r 5
  -d - destination folder for archive
  -s - source folder of archive files
  -n - files to archive
  -x - files to exclude from archiving
  -c - archive compression type: gz, bz2 or none
  -m - mailbox to notify (you need mail/mailx util and MTA installed)
  -r - retention of archive files in days
 "
   exit 1
}

while getopts ":s:d:c:n:x:m:r:h" opt; do
  case "$opt" in
    s) sourcedir=$OPTARG ;;
    d) dest=$OPTARG ;;
    c) compression=$OPTARG ;;
    n) name+=$OPTARG;;
    x) exclude+=$OPTARG;;
    m) mail=$OPTARG;;
    r) retention=$OPTARG;;
    h) help ;;
    *) echo "Please enter correct parameters"
      exit 1 ;;
  esac
done

function gz_command() {
touch /tmp/compression /tmp/exclude
for n in $name
do
find "$sourcedir" -name "$n" >> /tmp/compression
done
for x in $exclude
do
find "$sourcedir" -name "$x" >> /tmp/exclude
done
  tar -X /tmp/exclude -czf "$dest"/"$datefile".tar.gz -T /tmp/compression
  rm /tmp/compression /tmp/exclude
  }

function bz2_command() {
touch /tmp/compression /tmp/exclude
  for n in $name
  do
  find "$sourcedir" -name "$n" >> /tmp/compression
  done
  for x in $exclude
do
find "$sourcedir" -name "$x" >> /tmp/exclude
done
  tar -X /tmp/exclude -cjf "$dest"/"$datefile".tar.bz2 -T /tmp/compression
  rm /tmp/compression /tmp/exclude
  }
function tar_command() {
touch /tmp/compression /tmp/exclude
  for n in $name
  do
  find "$sourcedir" -name "$n" >> /tmp/compression
  done
  for x in $exclude
do
find "$sourcedir" -name "$x" >> /tmp/exclude
done
  tar -X /tmp/exclude -cf "$dest"/"$datefile".tar -T /tmp/compression
  rm /tmp/compression /tmp/exclude
  }
datefile="$(date +%F)"

function archivebz() {
if [[ -z $* ]]
then
echo "No options found, exiting"
exit 1
else
bz2_command
fi
if ! bz2_command;
then
echo "There must be an error. Please check attributes"
exit 1
elif [ "$mail" != "" ]
then
echo "Archiving completed. Your tar.bz2 archive is $dest"/"$datefile.tar.bz2" | mail -s "Archive" "$mail"
else
echo "Archiving completed. Your tar.bz2 archive is $dest"/"$datefile.tar.bz2"
fi
}

function archivegz() {
if [[ -z $* ]]
then
echo "No options found, exiting"
exit 1
else
gz_command
fi
if ! gz_command;
then
echo "There must be an error. Please check attributes"
exit 1
elif [ "$mail" != "" ]
then
echo "Archiving completed. Your tar.gz archive is $dest"/"$datefile.tar.gz" | mail -s "Archive" "$mail"
else
echo "Archiving completed. Your tar.gz archive is $dest"/"$datefile.tar.gz"
fi
}

function archive() {
if [[ -z $* ]]
then
echo "No options found, exiting"
exit 1
else
tar_command
fi
if ! tar_command;
then
echo "There must be an error. Please check attributes"
exit 1
elif [ "$mail" != "" ]
then
echo "Archiving completed. Your archive is $dest"/"$datefile.tar" | mail -s "Archive" "$mail"
else
echo "Archiving completed. Your archive is $dest"/"$datefile.tar"
fi
}

if [ -z "$dest" ]
then
echo "Please enter destination folder"
exit 1
fi
if [ "$compression" = "gz" ]
then
archivegz "$@"
find "$dest"/*.tar.gz -mtime +"$retention" -exec rm {} \;
elif [ "$compression" = "bz2" ]
then
archivebz "$@"
find "$dest"/*.tar.bz2 -mtime +"$retention" -exec rm {} \;
elif [ "$compression" = "none" ]
then
archive "$@"
find "$dest"/*.tar -mtime +"$retention" -exec rm {} \;
else
echo "Something wrong with attributes, exiting"
exit 1
fi

