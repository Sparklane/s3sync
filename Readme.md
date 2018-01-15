# S3 sync

This container will synchronize a local folder with an S3 folder according to a CRON expression.

## Requirements

### AWS Credentials

AWS CLI is used by the syncing script and you need to provide valid credentials or use an instance role profile.
If you wish to use credentials of an AWS IAM user, you can:

* Use environment variables :
```
docker run
  -e AWS_ACCESS_KEY_ID=EXAMPLEID \
  -e AWS_SECRET_ACCESS_KEY=MYSECRETKEY \
  -e AWS_REGION=us-east-1 \
...
```

* Mount your aws profile folder:
```
docker run
  -v ~/.aws:/root/.aws:ro \
  ...
```

### S3 bucket
You need an existing S3 bucket already created. The user or instance role you are using (cf. above) need to have appropriate policy allowing access to the S3 bucket.


## USAGE
In order to use s3Sync, you need to set the following

Env Var | Default | Description
--------|---------|------------
AWS_ACCESS_KEY_ID | *null* | (optional) Your AWS access key
AWS_SECRET_ACCESS_KEY | *null* | (optional) Your AWS secret access key
AWS_REGION | us-west-1 | Your AWS AWS_REGION
FROM_PATH | *null* | A local path or s3 path you need to sync *from* (ex: `/data` or `s3://mybucket/mypath/`)
DEST_PATH | *null* | A local path or s3 path you need to sync *from* (ex: `/data` or `s3://mybucket/mypath/`)
ALLOW_DELETE | false | if true, deletes will also be sync to DEST_PATH
CRON | * * * * * |  a valid cron expression (ex: `*/5 * * * *` runs every 5 minutes). By default: every minutes.
DOWNLOAD_ON_START | false |  if true, it will download all content of DEST_PATH back to FROM_PATH at launch


## Examples

* from a local folder to S3 path, allowing deletes, mounting a local volume:
```
docker run --name s3sync \
  -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
  -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
  -e AWS_REGION=us-east-1 \
  -e FROM_PATH=/data \
  -e DEST_PATH=s3://mybucket/myfolder/ \
  -e ALLOW_DELETE=true \
  -v $PWD/data/:/data \
  sparklane/s3sync
```

* from a S3 bucket to local folder, no deletes, no shared volume, hourly:
```
docker run --name s3sync \
  -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
  -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
  -e AWS_REGION=us-east-1 \
  -e FROM_PATH=s3://mybucket/myfolder/ \
  -e DEST_PATH=/data \
  -e ALLOW_DELETE=false \
  -e CRON='0 * * * *' \
  sparklane/s3sync
```
