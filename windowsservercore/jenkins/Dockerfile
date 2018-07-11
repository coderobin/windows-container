FROM microsoft/windowsservercore:10.0.14393.2312
LABEL maintainer="xied75@gmail.com"

ENV JENKINS_VERSION=2.121.1 JENKINS_HOME=C:/JENKINS_HOME

EXPOSE 8080 50000
VOLUME C:/JENKINS_HOME

COPY noStart.mst C:/
COPY simple_monitor.ps1 C:/

RUN powershell -Command \
    wget http://mirrors.jenkins-ci.org/windows-stable/jenkins-%JENKINS_VERSION%.zip -OutFile \jenkins-%JENKINS_VERSION%.zip; \
    Expand-Archive -Path \jenkins-%JENKINS_VERSION%.zip -DestinationPath /; \
    Start-Process -FilePath msiexec.exe -ArgumentList /i, jenkins.msi, TRANSFORMS=noStart.mst, /qn, /L, jenkins.install.log -PassThru -Wait; \
    rm \jenkins-%JENKINS_VERSION%.zip; \
    rm \jenkins.msi; \
    rm \noStart.mst; \
    $xml = (Get-Content \"%ProgramFiles(x86)%\Jenkins\Jenkins.xml\") -as [Xml]; \
    $xml.service.env.value = \"%JENKINS_HOME%\"; \
    $xml.Save(\"%ProgramFiles(x86)%\Jenkins\Jenkins.xml\");

ENTRYPOINT ["C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe", "c:\\simple_monitor.ps1"]
