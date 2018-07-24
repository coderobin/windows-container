# escape=`

FROM microsoft/windowsservercore:10.0.14393.2312
LABEL maintainer="xied75@gmail.com"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Install NuGet CLI
ENV NUGET_VERSION 4.7.0
RUN New-Item -Type Directory $Env:ProgramFiles\NuGet; `
    Invoke-WebRequest -UseBasicParsing https://dist.nuget.org/win-x86-commandline/v$Env:NUGET_VERSION/nuget.exe -OutFile $Env:ProgramFiles\NuGet\nuget.exe;

RUN New-Item -Type Directory c:\install_logs; `
    # Install .NET Framework 4.6.1 Developer Pack
    Invoke-WebRequest -UseBasicParsing https://download.microsoft.com/download/F/1/D/F1DEB8DB-D277-4EF9-9F48-3A65D4D8F965/NDP461-DevPack-KB3105179-ENU.exe -OutFile NDP461-DevPack-KB3105179-ENU.exe; `
    Start-Process -FilePath "C:\NDP461-DevPack-KB3105179-ENU.exe" -ArgumentList /Passive, /NoRestart, /Log, c:\install_logs\NDP461-DevPack-KB3105179-ENU.log -PassThru -Wait; `
    Remove-Item NDP461-DevPack-KB3105179-ENU.exe; `
    # Install Portable Library targets
    Invoke-WebRequest -UseBasicParsing https://coderobin.blob.core.windows.net/public/Microsoft/update3/PortableLibrary.zip -OutFile PortableLibrary.zip; `
    Expand-Archive -Path PortableLibrary.zip -DestinationPath /; `
    Start-Process -FilePath msiexec.exe -ArgumentList /i, "C:\PortableLibrary\enu\PortableLibrary_DTPLP.msi", EXTUI=1, /qn, /L, c:\install_logs\PortableLibrary_DTPLP.install.log -PassThru -Wait; `
    Start-Process -FilePath msiexec.exe -ArgumentList /i, "C:\PortableLibrary\PortableLibrary_DTP.msi", EXTUI=1, /qn, /L, c:\install_logs\PortableLibrary_DTP.install.log -PassThru -Wait; `
    Remove-Item PortableLibrary.zip; `
    Remove-Item -Recurse -Force PortableLibrary; `
    # Install Build Tools 2017
    Invoke-WebRequest -UseBasicParsing https://download.visualstudio.microsoft.com/download/pr/c6e2b90d-9051-44bd-aef1-4ef3bdf8f084/30b5724c490239eee9608d63225b994f/vs_buildtools.exe -OutFile vs_buildtools.exe; `
    # Installer won't detect DOTNET_SKIP_FIRST_TIME_EXPERIENCE if ENV is used, must use setx /M
    setx /M DOTNET_SKIP_FIRST_TIME_EXPERIENCE 1; `
    Start-Process -FilePath 'C:\vs_buildtools.exe' -ArgumentList '--add', 'Microsoft.VisualStudio.Workload.MSBuildTools', '--quiet', '--norestart', '--nocache' -NoNewWindow -Wait; `
    Remove-Item vs_buildtools.exe; `
    Remove-Item -Force -Recurse \"${Env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\"; `
    Remove-Item -Force -Recurse ${Env:TEMP}\*;

ENV ROSLYN_COMPILER_LOCATION "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin\Roslyn"

# ngen assemblies queued by VS installers - must be done in cmd shell to avoid access issues
SHELL ["cmd", "/S", "/C"]
RUN \Windows\Microsoft.NET\Framework64\v4.0.30319\ngen update `
    & \Windows\Microsoft.NET\Framework\v4.0.30319\ngen update `
    & EXIT 0

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Set PATH in one layer to keep image size down.
RUN setx /M PATH $(${Env:PATH} `
    + \";${Env:ProgramFiles}\NuGet\" `
    + \";${Env:ProgramFiles(x86)}\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin\")
