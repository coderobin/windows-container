FROM windowsservercore
MAINTAINER xied75@gmail.com

RUN powershell -Command \
    Invoke-WebRequest https://coderobin.blob.core.windows.net/public/fakenet/x64/FakeNet.exe -OutFile $env:temp\fakenet64.exe; \
    Invoke-WebRequest https://coderobin.blob.core.windows.net/public/fakenet/x86/FakeNet.exe -OutFile $env:temp\fakenet.exe; \
    Copy C:\Windows\System32\net.exe C:\Windows\System32\net.exe.bak; \
    Copy C:\Windows\SysWOW64\net.exe C:\Windows\SysWOW64\net.exe.bak; \
    $acl1 = Get-Acl C:\Windows\System32\net.exe; \
    $acl11 = Get-Acl C:\Windows\System32\net.exe; \
    $acl2 = Get-Acl C:\Windows\SysWOW64\net.exe; \
    $acl21 = Get-Acl C:\Windows\SysWOW64\net.exe; \
    $permission = 'BUILTIN\Administrators','FullControl','Allow'; \
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission; \
    $acl11.SetAccessRule($accessRule); \
    Set-Acl C:\Windows\System32\net.exe -AclObject $acl11; \
    $acl21.SetAccessRule($accessRule); \
    Set-Acl C:\Windows\SysWOW64\net.exe -AclObject $acl21; \
    Copy $env:temp\fakenet64.exe C:\Windows\System32\net.exe; \
    Copy $env:temp\fakenet.exe C:\Windows\SysWOW64\net.exe; \
    Install-PackageProvider -Name Chocolatey -Force; \
    Install-Package -Name windows-sdk-10.1 -ProviderName Chocolatey -Force; \
    Remove-Item C:\Windows\System32\net.exe; \
    Remove-Item C:\Windows\SysWOW64\net.exe; \
    Rename-Item C:\Windows\System32\net.exe.bak C:\Windows\System32\net.exe; \
    Rename-Item C:\Windows\SysWOW64\net.exe.bak C:\Windows\SysWOW64\net.exe; \
    Set-Acl C:\Windows\System32\net.exe -AclObject $acl1; \
    Set-Acl C:\Windows\SysWOW64\net.exe -AclObject $acl2;


CMD ["powershell"]