FROM nginx:1.31-alpine

RUN apk add --no-cache \
    nginx-module-image-filter \
    openssl \
    curl \
    \
    && mkdir -p /etc/nginx/ssl \
    && openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
       -keyout /etc/nginx/ssl/key.pem \
       -out /etc/nginx/ssl/cert.pem \
       -subj "/C=BY/ST=Minsk/L=Minsk/O=DevOps/CN=localhost" \
    && rm -f /var/log/nginx/access.log /var/log/nginx/error.log \
    \
    && touch /var/log/nginx/access.log /var/log/nginx/error.log \
    && chown nginx:nginx /var/log/nginx/access.log /var/log/nginx/error.log
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

COPY nginx/ /usr/share/nginx/

EXPOSE 80 443