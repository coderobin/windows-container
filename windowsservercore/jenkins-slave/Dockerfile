FROM coderobin/windows-build-uwp-461:latest
MAINTAINER xied75@gmail.com

VOLUME C:/jenkins
COPY StartSlave.ps1 C:/

RUN powershell -Command \
    $session = New-Object Microsoft.PowerShell.Commands.WebRequestSession; \
    $cookie = New-Object System.Net.Cookie; \
    $cookie.Name = \"oraclelicense\"; \
    $cookie.Value = \"accept-securebackup-cookie\"; \
    $cookie.Domain = \"edelivery.oracle.com\"; \
    $session.Cookies.Add($cookie); \
    wget -Uri \"https://edelivery.oracle.com/otn-pub/java/jdk/8u112-b15/jre-8u112-windows-x64.exe\" -WebSession $session -TimeoutSec 90 -MaximumRedirection 10 -OutFile jre-8u112-windows-x64.exe; \
    Start-Process -FilePath jre-8u112-windows-x64.exe -ArgumentList /s -PassThru -Wait; \
    rm \jre-8u112-windows-x64.exe;

ENTRYPOINT ["C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe", "c:\\StartSlave.ps1"]
