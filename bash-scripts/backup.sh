#!/bin/bash

SOURCE_DIR="/home"
BACKUP_DIR="./logs"
DATE=$(date +%F)

mkdir -p $BACKUP_DIR

tar -czf $BACKUP_DIR/backup-$DATE.tar.gz $SOURCE_DIR

echo "Backup completed: backup-$DATE.tar.gz"