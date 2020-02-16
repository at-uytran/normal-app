FROM nginx

COPY hls.conf /etc/nginx/conf.d/hls.conf

RUN mkdir -p /usr/src/app
RUN mkdir -p /usr/src/app/hls-data

WORKDIR /usr/src/app
