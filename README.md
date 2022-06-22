# bash-lab
## bash scripts for learning 

### bash-archiving: scripts with different approaches to data backup.

##### Script1 retrieves data about articles from the PostgreSQL DB. 	
    • Received data stored as separate files in /local/files directory (one script launch – one data file)	
    • The script also compress and move files to /local/backups when there are more than 3 files in /local/files
##### Script2
    • Script2 works in detached mode and starts at system boot	
    • Script2 has /var/run/script_name.pid (should not be run by a second instance)	
    • Script2 is configurable (ENV, configuration, etc.)  	
    • Script2 checks /local/backups and sends mail to root according to its configuration (mailx needs to be installed):
        ◦ number of files in /local/backups directory is more than X
        ◦ total size of /local/backups directory is more than Y bytes

##### Script3
Usage example: $0 -s /path/to/sourcedir -d /path/to/destdir -c gz -n "\"*.txt *.sh"\" -x "\"log.txt test.sh"\" -m admin@site.com -r 5
  -d - destination folder for archive
  -s - source folder of archive files
  -n - files to archive
  -x - files to exclude from archiving
  -c - archive compression type: gz, bz2 or none
  -m - mailbox to notify (you need mail/mailx util and MTA installed)
  -r - retention of archive files in days
### Script that will back up important files.
Backups will be archived and compressed. The dates will be part of the archive name.
The list of files must be specified through a variable, with the possibility of overriding it through the script launch arguments, the default value is /etc.
Also you can exclude/include files by mask: *.txt, *.jpg, etc.