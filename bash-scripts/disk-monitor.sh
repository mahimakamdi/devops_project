#!/bin/bash

THRESHOLD=80

echo "Checking disk usage..."

df -H | grep -vE '^Filesystem|tmpfs|cdrom' | while read line; do
  usage=$(echo $line | awk '{print $5}' | sed 's/%//g')
  partition=$(echo $line | awk '{print $1}')

  if [ $usage -ge $THRESHOLD ]; then
    echo "WARNING: $partition usage is at ${usage}%"
  fi
done