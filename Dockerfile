FROM alpine:latest

RUN apk update && apk add --no-cache php82 php82-fpm php82-opcache php82-pdo php82-common php82-mbstring php82-json php82-session php82-xml php82-tokenizer 
RUN apk add --no-cache nginx supervisor

RUN mkdir -p /run/nginx /var/www/html 
RUN mkdir -p /var/run/php

COPY nginx.conf /etc/nginx/nginx.conf

WORKDIR /var/www/html/

COPY . .

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chown -R nginx:nginx /run/nginx
RUN chown -R nginx:nginx /var/www/html
RUN chown -R nginx:nginx /var/lib/nginx

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]