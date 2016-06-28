1.  The Problem:
    When you try to install the SDK, it will stop in the middle leaving you an incomplete state. The hero is *Windows Desktop Extension SDK-x86_en-us.msi*, despite all other 50+ MSIs install perfectly, this guy decided to call *C:\Program Files (x86)\Windows Kits\10\bin\x86\GenerateUnionWinMD.cmd*, within this script we got:
    > REM Check for elevation
    > net session >nul 2>&1
    > if %ERRORLEVEL% EQU 0 (
    >    ECHO Confirmed running as administrator
    > ) else (
    >    ECHO Error: You must run this script from an elevated command prompt.
    >    EXIT /B 2
    > )
    It was calling **net session** to check if you are running as administrator. And although we are admin inside the container, the **Server** service is not running, and we can't start it either, it's not supported as of TP5, full stop.

    [Reference Link on TechNet forum](https://social.msdn.microsoft.com/Forums/vstudio/en-US/bfc4c36d-88d3-4b65-9208-580ee1c1d19d/windows-10-sdk-10010240-the-installer-failed-fatal-error-during-installation-error-code?forum=vssetup#be5392c5-cdce-4e0f-8e36-0617a42caeb0)

2.  The solution:
    We fake the **net.exe** with a skeleton .net application which does not do anything, so long as exit with 0 to make the script happy. We replace the real net.exe with our fake one and put the real one back after the installation.

