#!/bin/sh
LOCAL_PATH=${LOCAL_PATH:-/data}
CRON=${CRON:-* * * * *}

echo Starting CRON
mkdir -p $LOCAL_PATH

echo "$CRON /sync.sh" >> /etc/crontabs/root
crond -l 2 -f
