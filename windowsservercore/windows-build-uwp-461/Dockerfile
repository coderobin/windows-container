FROM windowsservercore
MAINTAINER xied75@gmail.com

RUN powershell -Command \
    wget https://download.microsoft.com/download/F/1/D/F1DEB8DB-D277-4EF9-9F48-3A65D4D8F965/NDP461-DevPack-KB3105179-ENU.exe -OutFile NDP461-DevPack-KB3105179-ENU.exe; \
    Start-Process -FilePath "C:\NDP461-DevPack-KB3105179-ENU.exe" -ArgumentList /Passive, /NoRestart, /Log, NDP461-DevPack-KB3105179-ENU.log -PassThru -Wait; \
    rm NDP461-DevPack-KB3105179-ENU.exe; \
    wget https://coderobin.blob.core.windows.net/public/Microsoft/PortableLibrary.zip -OutFile PortableLibrary.zip; \
    Expand-Archive -Path PortableLibrary.zip -DestinationPath /; \
    Start-Process -FilePath msiexec.exe -ArgumentList /i, "C:\PortableLibrary\enu\PortableLibrary_DTPLP.msi", EXTUI=1, /qn, /L, PortableLibrary_DTPLP.install.log -PassThru -Wait; \
    Start-Process -FilePath msiexec.exe -ArgumentList /i, "C:\PortableLibrary\PortableLibrary_DTP.msi", EXTUI=1, /qn, /L, PortableLibrary_DTP.install.log -PassThru -Wait; \
    rm PortableLibrary.zip; \
    rm -Recurse -Force PortableLibrary; \
    wget http://download.microsoft.com/download/1/f/e/1fe5d584-c5a9-4aee-907a-421abe4c74f2/buildtools_full.exe -OutFile buildtools_full.exe; \
    Start-Process -FilePath "C:\buildtools_full.exe" -ArgumentList /Passive, /NoRestart, /Log, build-tools-2015.log -PassThru -Wait; \
    rm buildtools_full.exe; \
    wget https://coderobin.blob.core.windows.net/public/Microsoft/BuildTools_MSBuildNuGet.zip -OutFile BuildTools_MSBuildNuGet.zip; \
    Expand-Archive -Path BuildTools_MSBuildNuGet.zip -DestinationPath /; \
    Start-Process -FilePath msiexec.exe -ArgumentList /i, "C:\BuildTools_MSBuildNuGet\BuildTools_MSBuildNuGet.msi", /qn, /L, BuildTools_MSBuildNuGet.install.log -PassThru -Wait; \
    rm BuildTools_MSBuildNuGet.zip; \
    rm -Recurse -Force BuildTools_MSBuildNuGet; \
    wget https://dist.nuget.org/win-x86-commandline/latest/nuget.exe -OutFile C:\nuget.exe;

CMD [ "powershell" ]