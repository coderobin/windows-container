# escape=`

FROM coderobin/windows-build-uwp-461:10.0.14393.2312_15.7.180 AS build
LABEL maintainer="xied75@gmail.com"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN `
    # Install MSBuild Web targets
    Invoke-WebRequest -UseBasicParsing https://dotnetbinaries.blob.core.windows.net/dockerassets/MSBuild.Microsoft.VisualStudio.Web.targets.2018.05.zip -OutFile MSBuild.Microsoft.VisualStudio.Web.targets.zip; `
    Expand-Archive MSBuild.Microsoft.VisualStudio.Web.targets.zip -DestinationPath \"${Env:ProgramFiles(x86)}\Microsoft Visual Studio\2017\BuildTools\MSBuild\Microsoft\VisualStudio\v15.0\"; `
    Remove-Item -Force MSBuild.Microsoft.VisualStudio.Web.targets.zip; `
    # Download source from GitHub
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
    Invoke-WebRequest -UseBasicParsing https://api.github.com/repos/coderobin/nuget.server.web/zipball -OutFile NuGet.Server.Web.zip; `
    # Build and Publish
    Expand-Archive -Path NuGet.Server.Web.zip; `
    Move-Item .\NuGet.Server.Web\*\* .\NuGet.Server.Web\; `
    Start-Process -FilePath 'NuGet.exe' -ArgumentList 'restore', 'C:\NuGet.Server.Web\NuGet.Server.Web.sln' -NoNewWindow -Wait; `
    Start-Process -FilePath 'MSBuild.exe' -ArgumentList 'C:\NuGet.Server.Web\NuGet.Server.Web.sln', '/p:Configuration=Release', '/p:DeployOnBuild=True', '/p:PublishProfile=FolderProfile', '/p:AspnetMergePath=\"${Env:ProgramFiles(x86)}\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools\"' -NoNewWindow -Wait; `
    Remove-Item NuGet.Server.Web.zip;

FROM coderobin/iisexpress:10.0.14393.2312-10.0

EXPOSE 80

COPY --from=build /NuGet.Server.Web/NuGet.Server.Web/bin/Release/Publish/ /NuGet.Server.Web

# https://github.com/moby/moby/pull/31980
RUN Remove-Item C:\NuGet.Server.Web\Packages\Readme.txt

VOLUME C:/NuGet.Server.Web/Packages

CMD ["C:\\Program Files\\IIS Express\\iisexpress.exe", "/config:C:\\NuGet.Server.Web\\applicationhost.config", "/systray:false"]
