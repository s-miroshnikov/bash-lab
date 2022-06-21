#!/bin/bash

# Load database connection info
set -o allexport
source .env
set +o allexport

# Read query into a variable
sql="SELECT *  FROM Articles"


psql -t -A -c "${sql}" > /local/files/export$RANDOM

counterf=$(find /local/files/ -type f | wc -l)
if ((counterf > 3))
then
cd /local/files/  || exit
find . -type f -name 'export*' -print0 | xargs -0 tar czf /local/backups/export$RANDOM.tar.gz
rm -f /local/files/*
echo "Files compressed and moved to /local/backups"
else
echo "Export from library table completed."
fi