# escape=`

FROM microsoft/nanoserver:10.0.14393.2363
LABEL maintainer="xied75@gmail.com"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV MONGO_VERSION 2.6.6
ENV MONGO_URI http://downloads.mongodb.org/win32/mongodb-win32-x86_64-2.6.6.zip
ENV MONGO_SHA256 44eb6823d0166073163e25266192bdd29dc2cf1bffb2a5d3366d8a851c97e435
ENV MONGO_ZIP mongodb-win32-x86_64-2.6.6.zip

RUN `
    # Download mongo
    Invoke-WebRequest -UseBasicParsing $Env:MONGO_URI -OutFile $Env:MONGO_ZIP; `
    $hash = (Get-FileHash -Algorithm sha256 $Env:MONGO_ZIP).Hash; `
    if ($hash -ne $Env:MONGO_SHA256) { Throw \"Sha256 mismatch, aborting!\" }; `
    Expand-Archive $Env:MONGO_ZIP -Destination C:\; `
    Move-Item .\mongodb-win32-x86_64-2.6.6 mongodb; `
    Remove-Item $Env:MONGO_ZIP; `
    Remove-Item C:\mongodb\bin\*.pdb -Force;

# Set PATH in one layer to keep image size down.
RUN setx /M PATH $(${Env:PATH} + \";C:\mongodb\bin;\");

# weird requirements from mongo
VOLUME C:/data/db C:/data/configdb

EXPOSE 27017

CMD ["mongod"]
