#---------nginx-----------#
FROM debian:bullseye

#Install NGINX enviroment
RUN apt update && apt upgrade -y
RUN apt install nginx -y

#Install openssl
RUN apt install openssl -y


RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-subj "/C=PT/ST=PT/L=Lisboa/O=42PT/OU=42PT/CN=rprocopi.42.fr" \
-keyout /etc/ssl/nginx.key \
-out /etc/ssl/nginx.crt

#Copy .conf nginx file
COPY conf/nginx.conf /etc/nginx/conf.d/

ENTRYPOINT [ "nginx", "-g", "daemon off;"]