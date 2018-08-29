# escape=`

FROM microsoft/windowsservercore:10.0.14393.2312
LABEL maintainer="xied75@gmail.com"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV JRE_URI=http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jre-8u181-windows-x64.exe

ENV NEO4J_SHA256 79b79061e7ff3564136ec553a669fcd118833a59bd9b503c6e46df3b643f1da5
ENV NEO4J_TARBALL neo4j-community-2.3.12-windows.zip
ENV NEO4J_URI=http://dist.neo4j.org/neo4j-community-2.3.12-windows.zip
ENV NEO4J_HOME=C:\neo4j

RUN `
    # Install Java jre
    $session = New-Object Microsoft.PowerShell.Commands.WebRequestSession; `
    $cookie = New-Object System.Net.Cookie; `
    $cookie.Name = \"oraclelicense\"; `
    $cookie.Value = \"accept-securebackup-cookie\"; `
    $cookie.Domain = \"edelivery.oracle.com\"; `
    $session.Cookies.Add($cookie); `
    Invoke-WebRequest -UseBasicParsing $Env:JRE_URI -WebSession $session -TimeoutSec 90 -MaximumRedirection 10 -OutFile jre-8u181-windows-x64.exe; `
    Start-Process -FilePath jre-8u181-windows-x64.exe -ArgumentList '/s' -NoNewWindow -Wait; `
    Remove-Item jre-8u181-windows-x64.exe; `
    # Download neo4j
    Invoke-WebRequest -UseBasicParsing $Env:NEO4J_URI -OutFile $Env:NEO4J_TARBALL; `
    $hash = (Get-FileHash -Algorithm sha256 $Env:NEO4J_TARBALL).Hash; `
    if ($hash -ne $Env:NEO4J_SHA256) { Throw \"Sha256 mismatch, aborting!\" }; `
    Expand-Archive $Env:NEO4J_TARBALL -Destination C:\; `
    Move-Item C:\neo4j-community-2.3.12 C:\neo4j; `
    Remove-Item $Env:NEO4J_TARBALL; `
    # Set neo4j server to listen on 0.0.0.0
    (Get-Content C:\neo4j\conf\neo4j-server.properties).Replace('#org.neo4j.server.webserver.address=0.0.0.0', 'org.neo4j.server.webserver.address=0.0.0.0') | Set-Content C:\neo4j\conf\neo4j-server.properties; `
    # Install neo4j Windows Service, and stop it
    Import-Module -Name C:\neo4j\bin\Neo4j-Management.psd1; `
    Install-Neo4jServer; `
    Stop-Neo4jServer; `
    # Need to remove files due to Windows Container limitation on Volume
    Remove-Item -Recurse C:\neo4j\data\*; `
    # Download ServiceMonitor
    Invoke-WebRequest -UseBasicParsing -Uri \"https://dotnetbinaries.blob.core.windows.net/servicemonitor/2.0.1.3/ServiceMonitor.exe\" -OutFile \ServiceMonitor.exe;

VOLUME C:/neo4j/data

EXPOSE 7474 7473

ENTRYPOINT ["C:\\ServiceMonitor.exe", "Neo4j-Server"]
