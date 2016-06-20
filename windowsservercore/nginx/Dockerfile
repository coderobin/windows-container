FROM windowsservercore
MAINTAINER xied75@gmail.com

ENV NGINX_VERSION 1.11.1

RUN setx PATH %PATH%;C:\nginx-%NGINX_VERSION%;
EXPOSE 80 443

RUN powershell -Command \
    wget http://nginx.org/download/nginx-%NGINX_VERSION%.zip -outfile \nginx-%NGINX_VERSION%.zip; \
    Expand-Archive -Path \nginx-%NGINX_VERSION%.zip -DestinationPath /; \
    rm /nginx-%NGINX_VERSION%.zip

WORKDIR C:/nginx-$NGINX_VERSION

CMD c:/nginx-%NGINX_VERSION%/nginx.exe
