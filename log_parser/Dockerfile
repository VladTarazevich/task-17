FROM alpine:3.24 as builder

RUN apk update && apk add --no-cache procps gawk coreutils

COPY log_parser.sh /usr/local/bin/log_parser.sh

RUN chmod 755 /usr/local/bin/log_parser.sh

CMD ["/usr/local/bin/log_parser.sh"]
