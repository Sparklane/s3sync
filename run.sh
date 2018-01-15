#!/bin/sh
CRON=${CRON:-* * * * *}
AWS_REGION=${AWS_REGION:-us-west-1}

echo Starting CRON

if [ "$DOWNLOAD_ON_START" == "true" ]; then
  echo "$(date "+%Y-%m-%d %H:%M:%S") downloading on start $DEST_PATH to $FROM_PATH"
	aws --region $AWS_REGION s3 sync $DEST_PATH $FROM_PATH
fi

echo "$CRON /sync.sh" >> /etc/crontabs/root
crond -l 2 -f
