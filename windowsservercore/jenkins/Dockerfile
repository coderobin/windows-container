# escape=`

FROM microsoft/windowsservercore:10.0.14393.2312
LABEL maintainer="xied75@gmail.com"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV JENKINS_VERSION=2.121.3 JENKINS_HOME=C:/JENKINS_HOME

COPY noStart.mst C:/

RUN `
    # Install Portable Git
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
    Invoke-WebRequest -UseBasicParsing https://github.com/git-for-windows/git/releases/download/v2.18.0.windows.1/PortableGit-2.18.0-64-bit.7z.exe -OutFile PortableGit-2.18.0-64-bit.7z.exe; `
    Start-Process -FilePath PortableGit-2.18.0-64-bit.7z.exe -ArgumentList '-y', '-InstallPath="C:\\PortableGit"' -NoNewWindow -PassThru -Wait; `
    Remove-Item PortableGit-2.18.0-64-bit.7z.exe; `
    # Set Path
    setx /M PATH $(${Env:PATH} `
        + \";C:\PortableGit\bin\"); `
    Invoke-WebRequest -UseBasicParsing -Uri "https://dotnetbinaries.blob.core.windows.net/servicemonitor/2.0.1.3/ServiceMonitor.exe" -OutFile \ServiceMonitor.exe; `
    Invoke-WebRequest http://mirrors.jenkins-ci.org/windows-stable/jenkins-$Env:JENKINS_VERSION.zip -OutFile \jenkins-$Env:JENKINS_VERSION.zip; `
    Expand-Archive -Path \jenkins-$Env:JENKINS_VERSION.zip -DestinationPath /; `
    Start-Process -FilePath msiexec.exe -ArgumentList /i, jenkins.msi, TRANSFORMS=noStart.mst, /qn, /L, jenkins.install.log -PassThru -Wait -NoNewWindow; `
    Remove-Item \jenkins-$Env:JENKINS_VERSION.zip; `
    Remove-Item \jenkins.msi; `
    Remove-Item \noStart.mst; `
    $xml = (Get-Content \"${Env:ProgramFiles(x86)}\Jenkins\Jenkins.xml\") -as [Xml]; `
    $xml.service.env.value = \"$Env:JENKINS_HOME\"; `
    $xml.Save(\"${Env:ProgramFiles(x86)}\Jenkins\Jenkins.xml\");

EXPOSE 8080 50000
VOLUME $JENKINS_HOME

ENTRYPOINT ["C:\\ServiceMonitor.exe", "jenkins"]
