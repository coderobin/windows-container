FROM windowsservercore
MAINTAINER xied75@gmail.com

ENV JENKINS_VERSION 2.10

EXPOSE 8080 50000

COPY noStart.mst C:/

RUN powershell -Command \
    wget http://mirrors.jenkins-ci.org/windows/jenkins-%JENKINS_VERSION%.zip -OutFile \jenkins-%JENKINS_VERSION%.zip; \
    Expand-Archive -Path \jenkins-%JENKINS_VERSION%.zip -DestinationPath /; \
    Start-Process -FilePath msiexec.exe -ArgumentList /i, jenkins.msi, TRANSFORMS=noStart.mst, /qn, /L, jenkins.install.log -PassThru -Wait; \
    rm \jenkins-%JENKINS_VERSION%.zip; \
    rm \jenkins.msi; \
    rm \noStart.mst;

CMD [ "powershell" ]
