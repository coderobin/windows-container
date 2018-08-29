FROM microsoft/windowsservercore:10.0.14393.2312
LABEL maintainer="xied75@gmail.com"

ENV NGINX_VERSION 1.14.0

RUN setx PATH %PATH%;C:\nginx-%NGINX_VERSION%;
EXPOSE 80 443

RUN powershell -Command \
    Invoke-WebRequest http://nginx.org/download/nginx-%NGINX_VERSION%.zip -outfile \nginx-%NGINX_VERSION%.zip; \
    Expand-Archive -Path \nginx-%NGINX_VERSION%.zip -DestinationPath /; \
    rm /nginx-%NGINX_VERSION%.zip

WORKDIR C:/nginx-$NGINX_VERSION

CMD c:/nginx-%NGINX_VERSION%/nginx.exe
