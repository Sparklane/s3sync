#!/bin/sh

AWS_REGION=${AWS_REGION:-us-west-1}
ALLOW_DELETE=${ALLOW_DELETE:-false}

if [ "$ALLOW_DELETE" == "true" ]; then
	DELETE='--delete'
fi

echo "$(date "+%Y-%m-%d %H:%M:%S") sync $FROM_PATH to $DEST_PATH $DELETE"


RES=$(aws --region $AWS_REGION s3 sync --exact-timestamps $FROM_PATH $DEST_PATH $DELETE | wc -l  | awk '{print $1}')
echo "Number of file synchronized: $RES"


if [ $RES != 0 ]; then
	if [ "$LINKED_CONTAINER" != "" ]; then
			# Killing linked container, for it to take in account new file changes
			docker kill --signal=SIGHUP $LINKED_CONTAINER
	fi
else
  echo "No change"
fi
