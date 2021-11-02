FROM nginx:stable

COPY default.conf /etc/nginx/conf.d/default.conf
COPY fix-base-url.sh /docker-entrypoint.d/
COPY html /usr/share/nginx/html


