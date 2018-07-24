# escape=`

FROM microsoft/windowsservercore:10.0.14393.2312
LABEL maintainer="xied75@gmail.com"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Install-WindowsFeature Web-WHC; `
    Invoke-WebRequest -UseBasicParsing https://download.microsoft.com/download/C/E/8/CE8D18F5-D4C0-45B5-B531-ADECD637A1AA/iisexpress_amd64_en-US.msi -OutFile iisexpress_amd64_en-US.msi; `
    Start-Process -FilePath msiexec.exe -ArgumentList /i, "C:\iisexpress_amd64_en-US.msi", /qn, /L, iisexpress_amd64_en-US.install.log -PassThru -Wait; `
    Remove-Item iisexpress_amd64_en-US.msi; `
    Start-Process -FilePath 'C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Aspnet_regiis.exe' -ArgumentList '-ga', \"${Env:UserName}\" -NoNewWindow -Wait;
