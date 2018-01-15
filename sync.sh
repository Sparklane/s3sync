#!/bin/sh

AWS_REGION=${AWS_REGION:-us-west-1}
ALLOW_DELETE=${ALLOW_DELETE:-false}

if [ "$ALLOW_DELETE" == "true" ]; then
	DELETE='--delete'
fi

echo "$(date "+%Y-%m-%d %H:%M:%S") sync $FROM_PATH to $DEST_PATH $DELETE"

aws --region $AWS_REGION s3 sync $FROM_PATH $DEST_PATH $DELETE
