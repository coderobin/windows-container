FROM coderobin/windows-build-uwp-461
MAINTAINER xied75@gmail.com

EXPOSE 80

RUN powershell -Command \
    Install-WindowsFeature Web-WHC; \
    wget https://download.microsoft.com/download/C/E/8/CE8D18F5-D4C0-45B5-B531-ADECD637A1AA/iisexpress_amd64_en-US.msi -OutFile iisexpress_amd64_en-US.msi; \
    Start-Process -FilePath msiexec.exe -ArgumentList /i, "C:\iisexpress_amd64_en-US.msi", /qn, /L, iisexpress_amd64_en-US.install.log -PassThru -Wait; \
    rm iisexpress_amd64_en-US.msi; \
    wget https://coderobin.blob.core.windows.net/public/Microsoft/Microsoft.WebApplication.zip -OutFile Microsoft.WebApplication.zip; \
    Expand-Archive -Path Microsoft.WebApplication.zip -DestinationPath 'C:\Program Files (x86)\MSBuild\Microsoft\VisualStudio\v14.0\WebApplications' -Force; \
    rm Microsoft.WebApplication.zip; \
    wget https://github.com/git-for-windows/git/releases/download/v2.11.0.windows.1/PortableGit-2.11.0-64-bit.7z.exe -OutFile PortableGit-2.11.0-64-bit.7z.exe; \
    Start-Process -FilePath PortableGit-2.11.0-64-bit.7z.exe -ArgumentList '-y' -PassThru -Wait; \
    rm PortableGit-2.11.0-64-bit.7z.exe; \
    C:\PortableGit\bin\git.exe clone https://github.com/coderobin/nuget.server.web.git; \
    C:\nuget.exe restore C:\nuget.server.web\NuGet.Server.Web.sln; \
    Start-Process -FilePath 'C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe' -ArgumentList 'C:\nuget.server.web\NuGet.Server.Web.sln', '/p:Configuration=Release' -PassThru -Wait; \
    C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Aspnet_regiis.exe -ga 'user manager\containeradministrator'; \
    mkdir C:\nuget.server.web\NuGet.Server.Web\Packages;

VOLUME C:/nuget.server.web/NuGet.Server.Web/Packages

CMD ["C:\\Program Files\\IIS Express\\iisexpress.exe", "/config:C:\\nuget.server.web\\hostconfig\\applicationhost.config", "/systray:false"]
