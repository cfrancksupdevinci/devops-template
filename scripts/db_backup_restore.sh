#!/bin/bash
# Script to backup and restore the database

ACTION=$1
DB_NAME="my_database"
BACKUP_FILE="backup.sql"

if [ "$ACTION" == "backup" ]; then
  echo "Backing up the database..."
  mysqldump -u root -p $DB_NAME > $BACKUP_FILE
  echo "Backup completed: $BACKUP_FILE"
elif [ "$ACTION" == "restore" ]; then
  echo "Restoring the database..."
  mysql -u root -p $DB_NAME < $BACKUP_FILE
  echo "Restore completed."
else
  echo "Usage: $0 {backup|restore}"
fi