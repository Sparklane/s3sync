FROM alpine:3.7

LABEL maintainer "Sparklane devops@sparklane.fr"

RUN apk --no-cache add py-pip && \
  pip --no-cache-dir install awscli

COPY *.sh /


ENTRYPOINT /run.sh
