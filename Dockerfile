FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y nginx zip curl

# Prevent NGINX from running in daemon mode
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Download the 2048 game source code and unzip it into the web root
RUN curl -o /var/www/html/master.zip -L https://codeload.github.com/gabrielecirulli/2048/zip/master && \
    cd /var/www/html/ && \
    unzip master.zip && \
    mv 2048-master/* . && \
    rm -rf 2048-master master.zip

# Expose port 80
EXPOSE 80

# Start NGINX with custom config
CMD ["/usr/sbin/nginx", "-c", "/etc/nginx/nginx.conf"]
