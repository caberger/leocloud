FROM nginx:stable

COPY default.conf /etc/nginx/conf.d/default.conf
COPY ./html/*.html /usr/share/nginx/html/
COPY ./html/src/*.js /usr/share/nginx/html/src/
VOLUME /usr/share/nginx/html
