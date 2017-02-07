#!/bin/ash
set -e

: ${ACCESS_KEY:?"ACCESS_KEY env variable is required"}
: ${SECRET_KEY:?"SECRET_KEY env variable is required"}
: ${S3_PATH:?"S3_PATH env variable is required"}
: ${INFLUX_HOST:?"INFLUX_HOST env variable is required"}


echo "access_key=$ACCESS_KEY" >> /root/.s3cfg
echo "secret_key=$SECRET_KEY" >> /root/.s3cfg

echo 'Backup Influx metadata'
influxd backup -host $INFLUX_HOST:8088 /tmp/backup

# Replace colons with spaces to create list.
for db in ${DATABASES//:/ }; do
  echo "Creating backup for $db"
  influxd backup -database $db -host $INFLUX_HOST:8088 /tmp/backup
done

DATE=`date +%Y-%m-%d-%H-%M-%S`

s3cmd sync $PARAMS "/tmp/backup" "$S3_PATH/$DATE/"
