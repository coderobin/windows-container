FROM microsoft/windowsservercore
MAINTAINER xied75@gmail.com

RUN powershell -Command \
    wget https://download.visualstudio.microsoft.com/downlownload/pr/10674754/e64d79b40219aea618ce2fe10ebd5f0d/vs_BuildTools.exe -OutFile vs_BuildTools.exe; \
    Start-Process -FilePath "C:\vs_BuildTools.exe" -ArgumentList --add, Microsoft.VisualStudio.Workload.MSBuildTools, --quiet -PassThru -Wait; \
    rm vs_BuildTools.exe; \
    wget https://download.visualstudio.microsoft.com/download/pr/10677990/d68d54e233c956ff79799fdf63753c54/Microsoft.NET.Sdk.vsix -OutFile Microsoft.NET.Sdk.zip; \
    Expand-Archive -Path Microsoft.NET.Sdk.zip -DestinationPath /Microsoft.NET.Sdk; \
    cp -Recurse c:\Microsoft.NET.Sdk\Contents\MSBuild\Sdks\ 'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\'; \
    rm Microsoft.NET.Sdk.zip; \
    rmdir -Recurse c:\Microsoft.NET.Sdk; \
    wget https://download.visualstudio.microsoft.com/download/pr/10678382/d68d54e233c956ff79799fdf63753c54/NuGet.Tools.vsix -OutFile NuGet.Tools.zip; \
    Expand-Archive -Path NuGet.Tools.zip -DestinationPath /NuGet.Tools; \
    mkdir -Force 'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7\IDE\CommonExtensions\Microsoft\NuGet\'; \
    cp -Recurse c:\NuGet.Tools\* 'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7\IDE\CommonExtensions\Microsoft\NuGet\'; \
    rm NuGet.Tools.zip; \
    rmdir -Recurse c:\NuGet.Tools; \
    wget https://dist.nuget.org/win-x86-commandline/latest/nuget.exe -OutFile C:\nuget.exe; \
    .\nuget.exe install nuget.build.tasks.pack -version 4.0.0; \
    mkdir 'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\Sdks\NuGet.Build.Tasks.Pack'; \
    rm C:\NuGet.Build.Tasks.Pack.4.0.0\*.nupkg; \
    mv C:\NuGet.Build.Tasks.Pack.4.0.0\* 'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\Sdks\NuGet.Build.Tasks.Pack'; \
    rmdir C:\NuGet.Build.Tasks.Pack.4.0.0;

CMD [ "powershell" ]
