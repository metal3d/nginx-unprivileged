FROM alpine:latest
ARG UID=1001

RUN set -xe; \
    apk add --no-cache nginx ca-certificates; \
    sed -i "s/100/$UID/g;s/101/0/g" /etc/passwd; \
    mkdir -p /run/nginx /var/tmp/nginx /var/log/nginx /var/www; \
    chown -R $UID:0 /run/nginx /var/tmp/nginx /var/log/nginx /var/www; \
    chmod ug+rw /run/nginx /var/tmp/nginx /var/log/nginx /var/www; \
    sed -i 's/80/8080/g' /etc/nginx/conf.d/default.conf; \
    sed -i '/^user nginx/d' /etc/nginx/nginx.conf; \
    ln -sf /dev/stdout /var/log/nginx/access.log; ln -sf /dev/stderr /var/log/nginx/error.log

USER 1001
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]


