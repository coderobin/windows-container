# escape=`

FROM microsoft/windowsservercore:10.0.14393.2312
LABEL maintainer="xied75@gmail.com"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN `
    Add-WindowsFeature Web-Server; `
    Invoke-WebRequest -UseBasicParsing -Uri "https://dotnetbinaries.blob.core.windows.net/servicemonitor/2.0.1.3/ServiceMonitor.exe" -OutFile "C:\ServiceMonitor.exe"

EXPOSE 80

ENTRYPOINT ["C:\\ServiceMonitor.exe", "w3svc"]
