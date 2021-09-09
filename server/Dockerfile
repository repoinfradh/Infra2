 
FROM docker.io/nginx:stable

RUN apt update ; \
    apt install -qqy openjdk-11-jre-headless curl htop vim fcgiwrap ; \
    mkdir /usr/lib/gci-bin -p; \
    mkdir /app;
    
COPY fcgiwrap.conf /etc/nginx/fcgiwrap.conf
COPY default.conf /etc/nginx/conf.d/default.conf
COPY app /usr/lib/cgi-bin/app
COPY holamundo.jar /app/holamundo.jar

RUN chmod 777 /usr/lib/cgi-bin/app ; \
    chmod 777 /app/holamundo.jar ;\
    sed -i 's;www-data;nginx;g' /etc/init.d/fcgiwrap

CMD service fcgiwrap start && nginx -g "daemon off;"
