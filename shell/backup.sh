#!/bin/bash
#
# Author:
#  Johannes Helgi Laxdal
#   http://www.laxdal.org
#    2012
#
# Simple script to manage weekly snapshot backups and daily incremental backups of multiple websites.
#
# This script assumes your web folder structure is something like this :
#   /path/to/www/site1/   (Directory containing everything that belongs to the website, script supports multiple sites, i.e. site1, site2, site3, etc)
#   /path/to/www/site1/public_html   (or whatever the document_root is called)
#   /path/to/www/site1/logs   (where you keep logs)
#   /path/to/www/site1/folder1   ([optional] any number of other directories or files)
#
#  The script backs up everything inside /path/to/www/site1/ except the logs directory, if you need or want
# to backup the logs directory then just edit the tar command and take out the --exclude statement.
#
#  The backup destination structure is like this
#    /path/to/backup/site1/   (directory containing every backup and incremental backup of the given site)
#    /path/to/backup/site1/weekXX   (every backup session is 1 week long and goes in its own directory where XX is the number week number)
#    /path/to/backup/site1/weekXX/backup.log   (the incremental backup log for Tar)
#    /path/to/backup/site1/weekXX/site1.backupY.tar.gz   (the backup file itself where Y is the day of the week. First backup file (lowest Y) is the snapshot and the rest are increments)
#    /path/to/backup/site1/weekXX/results.log   (the output from the tar executions)
#

#Get our Time Variables
WEEK="$(date +"%V")"
DOW="$(date +"%u")"
DATE="$(date +"%d/%m/%y")"

# Begin our benchmark
START=$(($(date +%s%N)/1000000))

# What do we want to backup (/path/to/www/ in the description)
SOURCE_ROOT="$HOME"

# Where do we store all our backups (/path/to/backup/ in the description)
DESTINATION_ROOT="$HOME/backup/sites/"

# Then we need to make sure the directory we need to backup does indeed exist
if [ ! -d "$SOURCE_ROOT" ]; then
  echo "Backup source does not exist."
  exit 1 # Backup target doesn't exist
fi

# First let's make sure the directory where we store our backups exists.
if [ ! -d "$DESTINATION_ROOT" ]; then
  echo "Backup destination does not exist."
  exit 1 # Backup store doesn't exist.
fi

# Beginning Daily Backup Process
echo "Beginning Daily Backup : $DATE "

# Get a list of all the sites we want to backup
#SITES="$(ls "$SOURCE_ROOT")"
SITES="sunrint sunriseimmigration"
#SITES="sunrint"

# Go through all of our sites
for SITE in $SITES
do
 # Announce our current target
 echo "Processing $SITE"

 # Speed test start
 SITESTART=$(($(date +%s%N)/1000000))

 # Does our site backup directory exist?
  if [ ! -d "$DESTINATION_ROOT/$SITE" ]; then
    echo "Site Backup Directory doesn't exist, we need to create it"
    mkdir "$DESTINATION_ROOT/$SITE"
  fi

 # Does our weekly backup directory exist?
 if [ ! -d "$DESTINATION_ROOT/$SITE/week$WEEK" ]; then
  echo "Weekly Backup Directory doesn't exist, we need to create it"
  mkdir "$DESTINATION_ROOT/$SITE/week$WEEK"
 fi

 # We should now be ready to begin backing up. We skip the Logs,.git, we (I) don't need to back them up.
 tar -g "$DESTINATION_ROOT/$SITE/week$WEEK/backup.log" -zcvpf "$DESTINATION_ROOT/$SITE/week$WEEK/$SITE.backup$DOW.tar.gz" --exclude="$SITE/logs/*" --exclude="$SITE/logs" --exclude-vcs -C $SOURCE_ROOT $SITE >> $DESTINATION_ROOT/$SITE/week$WEEK/results.log 2>&1 || echo "There was an error executing tar"

 # delete old backups keeping 2
 echo "Deleting old backups..."
 cd $DESTINATION_ROOT/$SITE
 ls -t | sed 1,1d | while read folder; do rm -r $folder; done

 # Calculate how long we took
 SITEEND=$(($(date +%s%N)/1000000))
 SITETAKEN=$((SITEEND - SITESTART))

 # We should now be done
 echo "Done processing $SITE in $SITETAKEN ms"
done

# Get the Unixtimestamp of when we end
END=$(($(date +%s%N)/1000000))
TAKEN=$((END - START))

# We're done
echo "Done backing up in $TAKEN ms"
