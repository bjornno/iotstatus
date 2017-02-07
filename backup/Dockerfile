FROM influxdb:1.1-alpine

# Backup the following databases, seperator ":"
ENV DATABASES=db1:db2

# S3CMD Version, default InfluxDB host
ENV S3CMD_VERSION=1.6.1
ENV INFLUX_HOST=influxdb

# Copy S3CMD config
#ADD s3cfg /root/.s3cfg

# Some tiny helpers 
RUN apk update && apk add ca-certificates && update-ca-certificates && apk add openssl
RUN apk add --no-cache bash py2-pip py-setuptools ca-certificates
RUN pip install python-magic

# Change workdir
WORKDIR "/tmp"

# Download and install S3CMD
RUN wget https://github.com/s3tools/s3cmd/releases/download/v${S3CMD_VERSION}/s3cmd-${S3CMD_VERSION}.tar.gz
RUN tar xzf s3cmd-${S3CMD_VERSION}.tar.gz
RUN cd s3cmd-${S3CMD_VERSION} && python setup.py install

# cleanup
RUN rm -rf /var/cache/apk/* /tmp/s3cmd-${S3CMD_VERSION} /tmp/s3cmd-${S3CMD_VERSION}.tar.gz

# Backup script
COPY backup.sh /bin/backup.sh
RUN chmod +x /bin/backup.sh

# Backup directory
RUN mkdir -p /tmp/backup

# Setup crontab
COPY cron.conf /var/spool/cron/crontabs/root

# Run Cron in foreground
CMD crond -l 0 -f
