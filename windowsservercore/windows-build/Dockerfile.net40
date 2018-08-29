# escape=`

FROM microsoft/windowsservercore:10.0.14393.2312
LABEL maintainer="xied75@gmail.com"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Install NuGet CLI
ENV NUGET_VERSION 4.7.0
RUN New-Item -Type Directory $Env:ProgramFiles\NuGet; `
    Invoke-WebRequest -UseBasicParsing https://dist.nuget.org/win-x86-commandline/v$Env:NUGET_VERSION/nuget.exe -OutFile $Env:ProgramFiles\NuGet\nuget.exe;

RUN New-Item -Type Directory c:\install_logs; `
    # install Microsoft .NET Framework 4 Multi-Targeting Pack 4.0.30319
    Invoke-WebRequest -UseBasicParsing https://download.visualstudio.microsoft.com/download/pr/10661178/e654115b07b2b9ea7883d5fe702f153a/netfx_dtp.msi -OutFile netfx_dtp.msi; `
    Invoke-WebRequest -UseBasicParsing https://download.visualstudio.microsoft.com/download/pr/10661178/e654115b07b2b9ea7883d5fe702f153a/netfx_dtp.cab -OutFile netfx_dtp.cab; `
    Start-Process -FilePath msiexec.exe -ArgumentList /i, 'C:\netfx_dtp.msi', EXTUI=1, /qn, /L, c:\install_logs\netfx_dtp.msi.install.log -PassThru -Wait; `
    Remove-Item netfx_dtp.msi; `
    Remove-Item netfx_dtp.cab; `
    # install Build Tools 2017
    Invoke-WebRequest -UseBasicParsing https://download.visualstudio.microsoft.com/download/pr/c6e2b90d-9051-44bd-aef1-4ef3bdf8f084/30b5724c490239eee9608d63225b994f/vs_buildtools.exe -OutFile vs_buildtools.exe; `
    # Installer won't detect DOTNET_SKIP_FIRST_TIME_EXPERIENCE if ENV is used, must use setx /M
    setx /M DOTNET_SKIP_FIRST_TIME_EXPERIENCE 1; `
    Start-Process -FilePath 'C:\vs_buildtools.exe' -ArgumentList '--add', 'Microsoft.VisualStudio.Workload.MSBuildTools', '--add', 'Microsoft.VisualStudio.Component.NuGet.BuildTools', '--quiet', '--norestart', '--nocache' -NoNewWindow -Wait; `
    Remove-Item vs_buildtools.exe; `
    Remove-Item -Force -Recurse \"${Env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\"; `
    Remove-Item -Force -Recurse ${Env:TEMP}\*;

ENV ROSLYN_COMPILER_LOCATION "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin\Roslyn"

# ngen assemblies queued by VS installers - must be done in cmd shell to avoid access issues
SHELL ["cmd", "/S", "/C"]
RUN \Windows\Microsoft.NET\Framework64\v4.0.30319\ngen update `
    && \Windows\Microsoft.NET\Framework\v4.0.30319\ngen update

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Set PATH in one layer to keep image size down.
RUN setx /M PATH $(${Env:PATH} `
    + \";${Env:ProgramFiles}\NuGet\" `
    + \";${Env:ProgramFiles(x86)}\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin\")
