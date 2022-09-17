FROM nginx:mainline-alpine

RUN rm /etc/nginx/conf.d/*

ADD app/conf/app.conf /etc/nginx/conf.d/

ADD app/src /usr/share/nginx/html/