# escape=`

FROM coderobin/windows-build-net40:10.0.14393.2312_15.7.180
LABEL maintainer="xied75@gmail.com"

ENV JRE_URI=http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jre-8u181-windows-x64.exe

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

VOLUME C:/jenkins

COPY StartSlave.ps1 C:/

RUN `
    # Install Portable Git
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
    Invoke-WebRequest -UseBasicParsing https://github.com/git-for-windows/git/releases/download/v2.18.0.windows.1/PortableGit-2.18.0-64-bit.7z.exe -OutFile PortableGit-2.18.0-64-bit.7z.exe; `
    Start-Process -FilePath PortableGit-2.18.0-64-bit.7z.exe -ArgumentList '-y', '-InstallPath="C:\\PortableGit"' -NoNewWindow -PassThru -Wait; `
    Remove-Item PortableGit-2.18.0-64-bit.7z.exe; `
    # Set Path
    setx /M PATH $(${Env:PATH} `
    + \";C:\PortableGit\bin\"); `
    # Install Java jre
    $session = New-Object Microsoft.PowerShell.Commands.WebRequestSession; `
    $cookie = New-Object System.Net.Cookie; `
    $cookie.Name = \"oraclelicense\"; `
    $cookie.Value = \"accept-securebackup-cookie\"; `
    $cookie.Domain = \"oracle.com\"; `
    $session.Cookies.Add($cookie); `
    Invoke-WebRequest -UseBasicParsing $Env:JRE_URI -WebSession $session -TimeoutSec 90 -MaximumRedirection 10 -OutFile jre-8u181-windows-x64.exe; `
    Start-Process -FilePath jre-8u181-windows-x64 -ArgumentList '/s' -NoNewWindow -Wait; `
    Remove-Item jre-8u181-windows-x64.exe;

ENTRYPOINT ["C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe", "c:\\StartSlave.ps1"]
