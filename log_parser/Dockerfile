FROM alpine:3.24 as builder

RUN apk update && apk add --no-cache procps gawk coreutils && \
    adduser -D -H -s /sbin/nologin parseuser

COPY

COPY log_parser.sh /usr/local/bin/log_parser.sh

RUN chmod 755 /usr/local/bin/log_parser.sh

USER parseuser

CMD ["/usr/local/bin/log_parser.sh"]