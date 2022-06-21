# bash-lab
### bash scripts for learning 

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