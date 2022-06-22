# bash-lab
## bash scripts for learning 

### bash-archiving: scripts with different approaches to data backup.

### Script1 
<p> Script1 retrieves data about articles from the PostgreSQL DB. <br> Received data stored as separate files in /local/files directory (one script launch – one data file)	<br> The script also compress and move files to /local/backups when there are more than 3 files in /local/files
</p>

### Script2
<p>
Script2 works in detached mode and starts at system boot	<br>
Script2 has /var/run/script_name.pid (should not be run by a second instance)	<br>
Script2 is configurable (ENV, configuration, etc.)<br>
Script2 checks /local/backups and sends mail to root according to its configuration (mailx needs to be installed):<br>
- number of files in /local/backups directory is more than X <br>
- total size of /local/backups directory is more than Y bytes
</p>

### Script3
<p>Usage example: <br> 
<code> $0 -s /path/to/sourcedir -d /path/to/destdir -c gz -n "\"*.txt *.sh"\" -x "\"log.txt test.sh"\" -m admin@site.com -r 5  </code> <br>
-d - destination folder for archive <br>
-s - source folder of archive files <br>
-n - files to archive <br>
-x - files to exclude from archiving <br>
-c - archive compression type: gz, bz2 or none <br>
-m - mailbox to notify (you need mail/mailx util and MTA installed) <br>
-r - retention of archive files in days
</p>

<p> Script that will back up important files.
Backups will be archived and compressed. The dates will be part of the archive name.
The list of files must be specified through a variable, with the possibility of overriding it through the script launch arguments, the default value is /etc.
Also you can exclude/include files by mask: *.txt, *.jpg, etc.
</p>