# escape=`

FROM microsoft/windowsservercore:10.0.14393.2312
LABEL maintainer="xied75@gmail.com"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV ERL_URI http://erlang.org/download/otp_win64_19.3.exe
ENV RMQ_URI https://github.com/rabbitmq/rabbitmq-server/releases/download/rabbitmq_v3_6_6/rabbitmq-server-windows-3.6.6.zip

ENV RABBITMQ_BASE C:\rabbitmq_data
ENV ERLANG_HOME C:\erlang

ENV RABBITMQ_ENABLED_PLUGINS_FILE=C:\enabled_plugins

COPY enabled_plugins C:\enabled_plugins

RUN `
    # Download and Install Erlang
    Invoke-WebRequest -UseBasicParsing $Env:ERL_URI -OutFile otp_win64_19.3.exe; `
    Start-Process -FilePath otp_win64_19.3.exe -ArgumentList '/S', '/D=C:\erlang' -NoNewWindow -Wait; `
    Remove-Item otp_win64_19.3.exe; `
    # Download and Install Rabbitmq
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
    Invoke-WebRequest -UseBasicParsing $Env:RMQ_URI -OutFile rabbitmq-server-windows-3.6.6.zip; `
    Expand-Archive -Path rabbitmq-server-windows-3.6.6.zip -DestinationPath C:\; `
    Move-Item C:\rabbitmq_server-3.6.6 C:\rabbitmq; `
    Remove-Item rabbitmq-server-windows-3.6.6.zip;

# Start-Process -FilePath c:\rabbitmq\sbin\rabbitmq-service.bat -ArgumentList 'install' -NoNewWindow -Wait; `
# Enable Rabbitmq management plugin
# Start-Process -FilePath c:\rabbitmq\sbin\rabbitmq-plugins.bat -ArgumentList 'enable', 'rabbitmq_management', '--offline' -NoNewWindow -Wait -PassThru;

VOLUME $RABBITMQ_BASE

EXPOSE 5672 15672

CMD ["C:/rabbitmq/sbin/rabbitmq-server.bat"]
