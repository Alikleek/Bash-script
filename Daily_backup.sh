#!/bin/bash
SRC="/var"
DEST="/etc/backup"
DATE=$(date +%Y-%m-%d)
FILE="$DEST/back_$DATE.tar.gz"

mkdir -p "$DEST"

tar -czf "$FILE" "$SRC" >> /var/log/backup.log

find /var/log/ -type f -mtime +5 -name '*.log' -execdir tar -czf backup_log.gz -- '{}' \;
find /var/log/ -type f -mtime +5 -name '*.log' -execdir sudo rm -- '{}' \;
mv -p /var/log/backup_log.gz /etc/backup

echo "current backup log " | mailx -s "backup log" ali.kleek@gmail.com -A /var/log/backup.log
