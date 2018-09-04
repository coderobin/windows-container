# escape=`

FROM microsoft/windowsservercore:10.0.14393.2312
LABEL maintainer="xied75@gmail.com"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV NGINX_VERSION 1.14.0

RUN `
    Invoke-WebRequest -UseBasicParsing http://nginx.org/download/nginx-$Env:NGINX_VERSION.zip -outfile \nginx-$Env:NGINX_VERSION.zip; `
    Expand-Archive -Path \nginx-$Env:NGINX_VERSION.zip -DestinationPath /; `
    Remove-Item /nginx-$Env:NGINX_VERSION.zip; `
    New-Item -Type Directory \nginx-$Env:NGINX_VERSION\conf\sites-available; `
    New-Item -Type Directory \nginx-$Env:NGINX_VERSION\conf\sites-enabled; `
    Rename-Item \nginx-$Env:NGINX_VERSION\conf\nginx.conf nginx.conf.original;

COPY nginx.conf \nginx-$NGINX_VERSION\conf\
COPY default.conf \nginx-$NGINX_VERSION\conf\sites-enabled\

RUN setx /M PATH $(${Env:PATH} `
    + \";C:\nginx-${Env:NGINX_VERSION}\");

EXPOSE 80 443

WORKDIR C:/nginx-$NGINX_VERSION

CMD ["nginx.exe"]
