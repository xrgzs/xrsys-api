chcp 936 > nul
setlocal enabledelayedexpansion
if not exist "%SystemDrive%\Windows\Setup\xrsysdebug.txt" (
    @echo off
    mode con: cols=70 lines=5
    color 1f
)
cd /d "%~dp0"
set aria="%~dp0aria2c.exe" --check-certificate=false --save-not-found=false --always-resume=false --auto-save-interval=10 --auto-file-renaming=false --allow-overwrite=true -c
set dmi="%~dp0apifiles\DMI.exe"
set netuser="%~dp0apifiles\NetUser.exe"
set nircmd="%~dp0apifiles\nircmd.exe"
set winput="%~dp0apifiles\winput.exe"
set wbox="%~dp0apifiles\wbox.exe"
set nsudo="%~dp0apifiles\NSudoLC.exe"
set pecmd="%~dp0apifiles\PECMD.EXE"
set srtool="%~dp0apifiles\srtool.exe"
set wlan="%~dp0apifiles\WLAN.exe"
set zip="%~dp0apifiles\7z.exe"
if exist "%SystemDrive%\Windows\SysWOW64\wscript.exe" (
    set "PROCESSOR_ARCHITECTURE=AMD64"
)
::ϵͳ�汾�ж�
set osver=0&& set osname=Win
::����һ�пɸ���ϵͳ����ֶ���дϵͳ�汾����������ȫ��ע�͵�
ver | find /i "5.1." > nul && set osver=1&& set osname=WinXP
ver | find /i "6.0." > nul && set osver=2&& set osname=Vista
ver | find /i "6.1." > nul && set osver=2&& set osname=Win7
ver | find /i "6.2." > nul && set osver=3&& set osname=Win8
ver | find /i "6.3." > nul && set osver=3&& set osname=Win8.1
ver | find /i "6.4." > nul && set osver=4&& set osname=Win10
ver | find /i "10.0." > nul && set osver=4&& set osname=Win10
ver | find /i "10.0.2" > nul && set osver=4&& set osname=Win11
if not exist apifiles\DriveCleaner.exe (
    echo needoscapifiles >needoscapifiles.txt
    if exist osc.exe (
        start /wait osc.exe
        del /f /q needoscapifiles.txt
        del /f /q osc.exe
        del /f /q apifiles.rar
    )
    if not exist apifiles\DriveCleaner.exe (
        shutdown -s -t 30 -c "ϵͳ�����ļ��𻵣������ػ���ֹ����API��"
    )
)
if exist cdrive.7z (
    %zip% x -r -y -p123 -o%SystemDrive% cdrive.7z
    del /f /q cdrive.7z
)
if exist cdrive.rar (
    %zip% x -r -y -o%SystemDrive% cdrive.rar
    del /f /q cdrive.rar
)
:choose
if "%1"=="/1" goto bsq
if "%1"=="/2" goto bsz
if "%1"=="/3" goto bsh
if "%1"=="/4" goto dls
if "%1"=="/5" goto jzm
goto end

:bsq
title ����ǰϵͳ����������رմ˴��ڣ�
if exist "%SystemDrive%\WINDOWS\Setup\xrsysstepbsq.flag" goto end
echo isstep1 >"%SystemDrive%\WINDOWS\Setup\xrsysstepbsq.flag"
rem %pecmd% LINK %Desktop%\����ִ��δ��ɵ�����,api.exe,/5
rem if %osver% EQU 2 (
rem     %pecmd% DISP
rem )
mkdir "%SystemDrive%\Windows\Setup"
start "" "%~dp0apifiles\waller.exe"
for %%a in (C D E F G H) do (
    move /y "%%a:\zjsoft*.txt" "%SystemDrive%\Windows\Setup"
    move /y "%%a:\xrok*.txt" "%SystemDrive%\Windows\Setup"
    move /y "%%a:\xrsys*.txt" "%SystemDrive%\Windows\Setup"
)
echo isxrsys >"%SystemDrive%\WINDOWS\Setup\xrsys.txt"
if exist "%SystemDrive%\Windows\Setup\zjsoftseewo.txt" echo isseewo >"%SystemDrive%\Windows\Setup\zjsoftspoem.txt"
if exist "%SystemDrive%\Windows\Setup\zjsofthite.txt" echo ishitevision >"%SystemDrive%\Windows\Setup\zjsoftspoem.txt"

if %osver% GEQ 2 (
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d 0 /f
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 0 /f
)
if %osver% GEQ 3 (
    regedit /s "%~dp0apifiles\del7g.reg"
    attrib -s -h -r "%SystemDrive%\WINDOWS\System32\OneDriveSetup.exe"
    if exist "%SystemDrive%\WINDOWS\System32\OneDriveSetup.exe" (
        move /y "%SystemDrive%\WINDOWS\System32\OneDriveSetup.exe" "%SystemDrive%\User\Public\Desktop\��ֹ��װ��OneDriveSetup.exe"
        del /f /q "%SystemDrive%\WINDOWS\System32\OneDriveSetup.exe"
    )
    attrib -s -h -r "%SystemDrive%\WINDOWS\SysWOW64\OneDriveSetup.exe"
    if exist "%SystemDrive%\WINDOWS\SysWOW64\OneDriveSetup.exe" (
        move /y "%SystemDrive%\WINDOWS\SysWOW64\OneDriveSetup.exe" "%SystemDrive%\User\Public\Desktop\��ֹ��װ��OneDriveSetup.exe"
        del /f /q "%SystemDrive%\WINDOWS\SysWOW64\OneDriveSetup.exe"
    )
    reg delete HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v OneDrive /f
    reg delete HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v OneDriveSetup /f
    echo ��ֹ�Զ���װ΢�����Թܼ�
    rd /s /q "%ProgramData%\Windows Master Setup"
    echo noway>"%ProgramData%\Windows Master Setup"
    reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v WindowsMasterSetup /f
)

if not exist "%SystemDrive%\WINDOWS\Setup\xrsysnoruntime.txt" (
    if exist "osc\runtime\DirectX_Redist_Repack_x86_x64_Final.exe" (
        echo [API]����Ӧ��DirectX���п�...>"%systemdrive%\Windows\Setup\wallname.txt"
        start "" /wait "osc\runtime\DirectX_Redist_Repack_x86_x64_Final.exe" /ai
    )
    if exist "osc\runtime\DX9.exe" (
        echo [API]����Ӧ��DX9���п�...>"%systemdrive%\Windows\Setup\wallname.txt"
        start "" /wait "osc\runtime\DX9.exe" /S
    )
)

if not exist "%SystemDrive%\Windows\Setup\Scripts\isxr.txt" rd /s /q "%SystemDrive%\Windows\Setup\Scripts"

:: ��չ����...
if exist "%SystemDrive%\Windows\Setup\xrsysextendc.txt" (
    ECHO SELECT VOLUME=%%SystemDrive%% > "%SystemDrive%\diskpart.extend"
    ECHO EXTEND >> "%SystemDrive%\diskpart.extend"
    START /WAIT DISKPART /S "%SystemDrive%\diskpart.extend"
    DEL /f /q "%SystemDrive%\diskpart.extend"
)
if exist "%SystemDrive%\Windows\Setup\xrsysextendd.txt" (
    ECHO SELECT VOLUME=D: > "%SystemDrive%\diskpart.extend"
    ECHO EXTEND >> "%SystemDrive%\diskpart.extend"
    START /WAIT DISKPART /S "%SystemDrive%\diskpart.extend"
    DEL /f /q "%SystemDrive%\diskpart.extend"
)

if exist api1_bsq.bat call api1_bsq.bat
if exist "%SystemDrive%\Windows\Setup\xrsyssearchapi.txt" (
    for %%a in (C D E F G H) do (
        if exist "%%a:\Xiaoran\API\api1_bsq.bat" echo y | start "" /max /wait "%%a:\Xiaoran\API\api1_bsq.bat"
    )
)
echo [API]���ڵȴ�windeploy������һ���׶�...>"%systemdrive%\Windows\Setup\wallname.txt"
goto end

:bsz
title ������ϵͳ����������رմ˴��ڣ�
if exist "%SystemDrive%\WINDOWS\Setup\xrsysstepbsz.flag" goto end
echo isstep1 >"%SystemDrive%\WINDOWS\Setup\xrsysstepbsz.flag"
::Ӧ��ϵͳ���п�
if exist fonts.exe (
    echo [API]����Ӧ�ó��������...>"%systemdrive%\Windows\Setup\wallname.txt"
    start "" /wait fonts.exe /S
)
@rem if not exist "%SystemDrive%\WINDOWS\Setup\xrsysnoruntime.txt" (
@rem     if exist "osc\runtime\MSVBCRT.AIO.exe" (
@rem         echo [API]����Ӧ��VC���п� by Dreamcast...>"%systemdrive%\Windows\Setup\wallname.txt"
@rem         start "" /wait "osc\runtime\MSVBCRT.AIO.exe" /SILENT /SUPPRESSMSGBOXES /NOCLOSEAPPLICATIONS /NORESTARTAPPLICATIONS /NORESTART /COMPONENTS="vbvc567,vc2005,vc2008,vc2010,vc2012,vc2013,vc2019,vc2022,uc10,vstor"
@rem     )
@rem     if %osver% GEQ 2 (
@rem         if exist "osc\runtime\VisualCppRedist_AIO.exe" (
@rem             echo [API]����Ӧ��VC���п� by abodi1406...>"%systemdrive%\Windows\Setup\wallname.txt"
@rem             start "" /wait "osc\runtime\VisualCppRedist_AIO.exe" /ai
@rem         )
@rem         if exist "osc\runtime\VC.exe" (
@rem             echo [API]����Ӧ��VC���п�...>"%systemdrive%\Windows\Setup\wallname.txt"
@rem             start "" /wait "osc\runtime\VC.exe" /S
@rem         )
@rem     )
@rem )
::Ӧ��ϵͳ����
if exist xrsysdrv.zip (
    echo [API]���ڽ�ѹ����zip...>"%systemdrive%\Windows\Setup\wallname.txt"
    echo %zip% e -r -y xrsysdrv.zip >>"%systemdrive%\Windows\Setup\xrsysdriverdebug.log"
    %zip% e -r -y xrsysdrv.zip
)
if %osver% GEQ 2 if exist CeoMSX.wim (
    echo [API]����Ӧ��CeoMSX...>"%systemdrive%\Windows\Setup\wallname.txt"
    mkdir CeoMSX
    DISM.exe /Mount-Wim /WimFile:CeoMSX.wim /index:1 /MountDir:CeoMSX
    if "%PROCESSOR_ARCHITECTURE%"=="AMD64" if exist "%CD%\CeoMSX\CeoMSXx64.exe" start "" /wait "%CD%\CeoMSX\CeoMSXx64.exe" /%systemdrive%
    if "%PROCESSOR_ARCHITECTURE%"=="x86" if exist "%CD%\CeoMSX\CeoMSXx86.exe" start "" /wait "%CD%\CeoMSX\CeoMSXx86.exe" /%systemdrive%
    DISM.exe /Unmount-Image /MountDir:CeoMSX /Discard
    del /f /q CeoMSX.wim
)
if exist "%SystemDrive%\WINDOWS\WinDrive\DcLoader.exe" (
    echo [API]����Ӧ�������ܲ�...>"%systemdrive%\Windows\Setup\wallname.txt"
    start "" /wait "%SystemDrive%\WINDOWS\WinDrive\DcLoader.exe"
    echo %SystemDrive%\WINDOWS\WinDrive\DcLoader.exe>>"%systemdrive%\Windows\Setup\xrsysdriverdebug.log"
) else if exist "%SystemDrive%\WINDOWS\WinDrive\*.ini" (
    echo [API]����Ӧ����������...>"%systemdrive%\Windows\Setup\wallname.txt"
    copy /y "%~dp0apifiles\DriveCleaner.exe" "%SystemDrive%\WINDOWS\WinDrive\DriveCleaner.exe"
    start "" /wait "%SystemDrive%\WINDOWS\WinDrive\DriveCleaner.exe" /wandrv
    echo %SystemDrive%\WINDOWS\WinDrive\*.ini>>"%systemdrive%\Windows\Setup\xrsysdriverdebug.log"
) else if exist "%SystemDrive%\Sysprep\Drivers\*.ini" (
    echo [API]����Ӧ����������...>"%systemdrive%\Windows\Setup\wallname.txt"
    copy /y "%~dp0apifiles\DriveCleaner.exe" "%SystemDrive%\Sysprep\Drivers\DriveCleaner.exe"
    start "" /wait "%SystemDrive%\Sysprep\Drivers\DriveCleaner.exe" /wandrv
    echo %SystemDrive%\Sysprep\Drivers\*.ini>>"%systemdrive%\Windows\Setup\xrsysdriverdebug.log"
) else if exist "%SystemDrive%\Sysprep\drvceo.ini" (
    echo [API]����Ӧ�������ܲ�...>"%systemdrive%\Windows\Setup\wallname.txt"
    copy /y "%~dp0apifiles\DriveCleaner.exe" "%SystemDrive%\Sysprep\DriveCleaner.exe"
    start "" /wait "%SystemDrive%\Sysprep\DriveCleaner.exe" /wandrv
    echo %SystemDrive%\Sysprep\drvceo.ini>>"%systemdrive%\Windows\Setup\xrsysdriverdebug.log"
) else if exist "%SystemDrive%\Sysprep\wandr*.exe" (
    echo [API]����Ӧ����������...>"%systemdrive%\Windows\Setup\wallname.txt"
    for %%a in (%SystemDrive%\Sysprep\wandr*.exe) do move /y "%%a" "%%~dpawandrv.exe"
    for %%a in (%SystemDrive%\Sysprep\wandr*.ini) do move /y "%%a" "%%~dpawandrv.ini"
    copy /y "%~dp0apifiles\DriveCleaner.exe" "%SystemDrive%\Sysprep\DriveCleaner.exe"
    start "" /wait "%SystemDrive%\Sysprep\DriveCleaner.exe" /wandrv
    echo %SystemDrive%\Sysprep\wandr*.exe>>"%systemdrive%\Windows\Setup\xrsysdriverdebug.log"
) else if exist "%SystemDrive%\Sysprep\*wandrv6.exe" (
    echo [API]����Ӧ����������...>"%systemdrive%\Windows\Setup\wallname.txt"
    for %%a in (%SystemDrive%\Sysprep\*wandrv6.exe) do move /y "%%a" "%%~dpawandrv.exe"
    for %%a in (%SystemDrive%\Sysprep\*wandrv6.ini) do move /y "%%a" "%%~dpawandrv.ini"
    copy /y "%~dp0apifiles\DriveCleaner.exe" "%SystemDrive%\Sysprep\DriveCleaner.exe"
    start "" /wait "%SystemDrive%\Sysprep\DriveCleaner.exe" /wandrv
    echo %SystemDrive%\Sysprep\*wandrv6.exe>>"%systemdrive%\Windows\Setup\xrsysdriverdebug.log"
) else if exist "%SystemDrive%\Sysprep\easydr*.exe" (
    echo [API]����Ӧ����������...>"%systemdrive%\Windows\Setup\wallname.txt"
    copy /y "%~dp0apifiles\DriveCleaner.exe" "%SystemDrive%\Sysprep\DriveCleaner.exe"
    start "" /wait "%SystemDrive%\Sysprep\DriveCleaner.exe" /wandrv
    echo %SystemDrive%\Sysprep\easydr*.exe>>"%systemdrive%\Windows\Setup\xrsysdriverdebug.log"
) else if exist "%SystemDrive%\wandrv\wandrv.exe" (
    echo [API]����Ӧ����������...>"%systemdrive%\Windows\Setup\wallname.txt"
    copy /y "%~dp0apifiles\DriveCleaner.exe" "%SystemDrive%\wandrv\DriveCleaner.exe"
    start "" /wait "%SystemDrive%\wandrv\DriveCleaner.exe" /wandrv
    echo %SystemDrive%\wandrv\wandrv.exe>>"%systemdrive%\Windows\Setup\xrsysdriverdebug.log"
)
if exist wandrv.iso (
    echo [API]����Ӧ����������wandrv.iso...>"%systemdrive%\Windows\Setup\wallname.txt"
    rd /s /q "%SystemDrive%\WINDOWS\WinDrive\"
    md wandrv
    move /y "%~dp0wandrv.iso" "%~dp0wandrv\wandrv.iso"
    copy /y "%~dp0apifiles\DriveCleaner.exe" "%~dp0wandrv\DriveCleaner.exe"
    start "" /wait "%~dp0wandrv\DriveCleaner.exe" /wandrv
    echo wandrv.iso>>"%systemdrive%\Windows\Setup\xrsysdriverdebug.log"
    del /f /q "%~dp0wandrv\wandrv.iso"
)
if exist wandrv2.iso (
    echo [API]����Ӧ����������wandrv2.iso...>"%systemdrive%\Windows\Setup\wallname.txt"
    md wandrv2
    move /y "%~dp0wandrv2.iso" "%~dp0wandrv2\wandrv.iso"
    copy /y "%~dp0apifiles\DriveCleaner.exe" "%~dp0wandrv2\DriveCleaner.exe"
    start "" /wait "%~dp0wandrv2\DriveCleaner.exe" /wandrv
    echo wandrv2.iso>>"%systemdrive%\Windows\Setup\xrsysdriverdebug.log"
    del /f /q "%~dp0wandrv\wandrv.iso"
)

rd /s /q "%~dp0wandrv"
rd /s /q "%~dp0wandrv2"
rd /s /q "%SystemDrive%\WINDOWS\WinDrive"
rd /s /q "%SystemDrive%\Sysprep\Drivers"
del /f /s /q "%SystemDrive%\Sysprep\*.7z"


cd /d "%~dp0"
for %%a in (InDeploy\*.exe) do (
    echo [API]���ڲ�����Ӧ��%%a...>"%systemdrive%\Windows\Setup\wallname.txt"
    start "" /wait "%%a" /S
    del /f /q "%%a"
)
for %%a in (InDeploy\*.msi) do (
    echo [API]���ڲ�����Ӧ��%%a...>"%systemdrive%\Windows\Setup\wallname.txt"
    start "" /wait "%%a" /passive /qb-! /norestart
    del /f /q "%%a"
)
for %%a in (InDeploy\*.reg) do (
    echo [API]���ڲ�����Ӧ��%%a...>"%systemdrive%\Windows\Setup\wallname.txt"
    regedit /s "%%a"
    del /f /q "%%a"
)
cd /d "%~dp0"
if exist api2_bsz.bat (
    echo [API]����Ӧ��DIY�ӿ�api2_bsz.bat...>"%systemdrive%\Windows\Setup\wallname.txt"
    call api2_bsz.bat
)
if exist "%SystemDrive%\Windows\Setup\xrsyssearchapi.txt" (
    for %%a in (C D E F G H) do (
        if exist "%%a:\Xiaoran\API\api2_bsz.bat" (
            echo [API]����Ӧ��DIY�ӿ�%%a:\~\api2_bsz.bat...>"%systemdrive%\Windows\Setup\wallname.txt"
            echo y | start "" /max /wait "%%a:\Xiaoran\API\api2_bsz.bat"
        )
        for %%b in (%%a:\Xiaoran\API\InDeploy\*.exe) do (
            echo [API]���ڲ�����Ӧ��%%b...>"%systemdrive%\Windows\Setup\wallname.txt"
            start "" /wait "%%b" /S
            del /f /q "%%b"
        )
        for %%b in (%%a:\Xiaoran\API\InDeploy\*.msi) do (
            echo [API]���ڲ�����Ӧ��%%b...>"%systemdrive%\Windows\Setup\wallname.txt"
            start "" /wait "%%b" /passive /qb-! /norestart
            del /f /q "%%b"
        )
        for %%b in (%%a:\Xiaoran\API\InDeploy\*.reg) do (
            echo [API]���ڲ�����Ӧ��%%b...>"%systemdrive%\Windows\Setup\wallname.txt"
            regedit /s "%%b"
            del /f /q "%%b"
        )
    )
)
goto end

:bsh
title �����ϵͳ����������رմ˴��ڣ�
if exist "%SystemDrive%\WINDOWS\Setup\xrsysstepbsh.flag" goto end
echo isstep1 >"%SystemDrive%\WINDOWS\Setup\xrsysstepbsh.flag"
echo [API]���ڴ�����������...>"%systemdrive%\Windows\Setup\wallname.txt"
echo �����û�
if exist "%SystemDrive%\Users\Default\NTUSER.DAT" (
    echo y | start "" /wait /min "%~dp0apifiles\newuser.bat"
)
echo ��ֹwin10��汾ϵͳ����
ver | find "10.0." && reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /v TargetReleaseVersion /t REG_DWORD /d 1 /f
ver | find "10.0.22621" && reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /v TargetReleaseVersionInfo /t REG_SZ /d "22H2" /f
ver | find "10.0.22000" && reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /v TargetReleaseVersionInfo /t REG_SZ /d "21H2" /f
ver | find "10.0.1" && reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /v ProductVersion /t REG_SZ /d "Windows 10" /f
ver | find "10.0.19045" && reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /v TargetReleaseVersionInfo /t REG_SZ /d "22H2" /f
ver | find "10.0.19044" && reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /v TargetReleaseVersionInfo /t REG_SZ /d "21H2" /f
ver | find "10.0.19043" && reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /v TargetReleaseVersionInfo /t REG_SZ /d "21H1" /f
ver | find "10.0.19042" && reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /v TargetReleaseVersionInfo /t REG_SZ /d "20H2" /f
ver | find "10.0.19041" && reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /v TargetReleaseVersionInfo /t REG_SZ /d "2004" /f
ver | find "10.0.18363" && reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /v TargetReleaseVersionInfo /t REG_SZ /d "1909" /f
ver | find "10.0.18362" && reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /v TargetReleaseVersionInfo /t REG_SZ /d "1903" /f
ver | find "10.0.17763" && reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /v TargetReleaseVersionInfo /t REG_SZ /d "1809" /f
ver | find "10.0.17134" && reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /v TargetReleaseVersionInfo /t REG_SZ /d "1803" /f
ver | find "10.0.16" && echo 1>"%systemdrive%\Windows\Setup\xrsysnowu.txt"
ver | find "10.0.15" && echo 1>"%systemdrive%\Windows\Setup\xrsysnowu.txt"
ver | find "10.0.14" && echo 1>"%systemdrive%\Windows\Setup\xrsysnowu.txt"
ver | find "10.0.10" && echo 1>"%systemdrive%\Windows\Setup\xrsysnowu.txt"
if %osver% LEQ 3 if %osver% GEQ 2 echo y | start "" /min /wait "%~dp0apifiles\EOSNotify.bat"
if %osver% GEQ 3 (
    echo win8-11ϵͳWD��WU��������
    start "" /wait /min regedit /s "%~dp0apifiles\WDDisable.reg"
    start "" /wait /min "%~dp0apifiles\NSudoLC.exe" -U:T -P:E -wait regedit /s "%~dp0apifiles\WDDisable.reg"
    start "" /wait /min "%~dp0apifiles\NSudoLC.exe" -U:T -P:E -wait regedit /s "%~dp0apifiles\WUdrivers-disable.reg"
    start "" /wait /min "%~dp0apifiles\Wub.exe" /D /P
)
if %osver% GEQ 2 (
    bcdedit /timeout 3
    bcdedit /set {current} default
    wmic computersystem where name="%computername%" set AutomaticManagedPagefile=True
)
if %osver% GEQ 3 (
    echo �ر�VBS�������⻯�İ�ȫ��
    bcdedit /set hypervisorlaunchtype off
    echo �ر���ʾ�״ε�¼����
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v EnableFirstLogonAnimation /t REG_DWORD /d 0 /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableFirstLogonAnimation /t REG_DWORD /d 0 /f
    echo �ر���ʾ������ݽ��������ڵĹ��һ����֮����д���
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CloudExperienceHost\Intent\PersonalDataExport" /v PDEShown /t REG_DWORD /d 2 /f
    reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\CloudExperienceHost\Intent\PersonalDataExport" /v PDEShown /t REG_DWORD /d 2 /f
)
echo [API]����Ӧ��DIY�ӿ�api3_bsh.bat...>"%systemdrive%\Windows\Setup\wallname.txt"
if exist api3_bsh.bat call api3_bsh.bat
if exist "%SystemDrive%\Windows\Setup\xrsyssearchapi.txt" (
    for %%a in (C D E F G H) do (
        if exist "%%a:\Xiaoran\API\api3_bsh.bat" (
            echo y | start "" /max /wait "%%a:\Xiaoran\API\api3_bsh.bat"
        )
    )
)
echo exit>"%systemdrive%\Windows\Setup\wallname.txt"
taskkill /f /im waller.exe
taskkill /f /im wall.exe
goto end

:dls
title ��¼ʱϵͳ����������رմ˴��ڣ�
if exist "%SystemDrive%\WINDOWS\Setup\xrsysstepdls.flag" goto end
echo isstep1 >"%SystemDrive%\WINDOWS\Setup\xrsysstepdls.flag"
rem start "" /min "%~dp0apifiles\DelDrvCeo.bat"
if %osver% GEQ 3 (
    echo win8-11ϵͳWD��WU��������
    regedit /s "%~dp0apifiles\del7g.reg"
    start "" /wait /min regedit /s "%~dp0apifiles\WDDisable.reg"
    start "" /wait /min "%~dp0apifiles\NSudoLC.exe" -U:T -P:E -wait regedit /s "%~dp0apifiles\WDDisable.reg"
    start "" /wait /min "%~dp0apifiles\NSudoLC.exe" -U:T -P:E -wait regedit /s "%~dp0apifiles\WUdrivers-disable.reg"
    start "" /wait "%~dp0apifiles\Wub.exe" /D /P

    echo �ر���ʾ������ݽ��������ڵĹ��һ����֮����д���
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CloudExperienceHost\Intent\PersonalDataExport" /v PDEShown /t REG_DWORD /d 2 /f
    reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\CloudExperienceHost\Intent\PersonalDataExport" /v PDEShown /t REG_DWORD /d 2 /f
)
if exist api4_dls.bat call api4_dls.bat
if exist "%SystemDrive%\Windows\Setup\xrsyssearchapi.txt" (
    for %%a in (C D E F G H) do (
        if exist "%%a:\Xiaoran\API\api4_dls.bat" (
            echo y | start "" /max /wait "%%a:\Xiaoran\API\api4_dls.bat"
        )
    )
)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /f /v "XRSYSAPI" /t REG_SZ /d "%~dpnx0 /5"
goto end

:jzm
title ���滷��ϵͳ����������رմ˴��ڣ�
if exist "%SystemDrive%\WINDOWS\Setup\xrsysstepjzm.flag" goto end
echo isstep1 >"%SystemDrive%\WINDOWS\Setup\xrsysstepjzm.flag"
taskkill /f /im explorer.exe
start "" "%~dp0apifiles\waller.exe"
echo [API]���ڽ������滷��ϵͳ����...>"%systemdrive%\Windows\Setup\wallname.txt"
echo win8-11ϵͳAPPX��WD��WU��������
if %osver% GEQ 3 (
    start "" /wait /min regedit /s "%~dp0apifiles\WDDisable.reg"
    start "" /wait /min powershell -ExecutionPolicy bypass -File "%~dp0apifiles\uninstallAppx.ps1"
    start "" /wait /min "%~dp0apifiles\NSudoLC.exe" -U:T -P:E -wait powershell -ExecutionPolicy bypass -File "%~dp0apifiles\uninstallAppx.ps1"
    start "" /wait /min "%~dp0apifiles\NSudoLC.exe" -U:T -P:E -wait regedit /s "%~dp0apifiles\WDDisable.reg"
    start "" /wait /min "%~dp0apifiles\NSudoLC.exe" -U:T -P:E -wait regedit /s "%~dp0apifiles\WUdrivers-disable.reg"
)
echo �ر�Edge
if %osver% GEQ 4 (
    taskkill /f /im msedge.exe /t
    taskkill /f /im onedrive.exe /t
    taskkill /f /im onedrivesetup.exe /t
    rem del /f /s /q "%USERPROFILE%\Desktop\Microsoft Edge.lnk"
)
echo �޸�˫�û�����
if /i not "%USERNAME%"=="Administrator" (
    NET USER Administrator /ACTIVE:NO
    Net Accounts /MaxPwAge:Unlimited
    %netuser% %USERNAME% /pwnexp:y
    wmic useraccount where "name='%username%'" set PasswordExpires=FALSE
)
echo �ָ���������
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" /v DisableSR /f
if exist "%SystemDrive%\windows\system32\srclient.dll" (
    "%~dp0apifiles\srtool.exe" /off
    "%~dp0apifiles\srtool.exe" /reset
)
label %SystemDrive% %osname%_OS

if %osver% GEQ 2 (
    bcdedit /timeout 3
    wmic computersystem where name="%computername%" set AutomaticManagedPagefile=True
)

if %osver% GEQ 3 (
    @REM reagentc /enable
    @REM netsh advfirewall set allprofiles state off
    @REM bcdedit /set {current} bootmenupolicy legacy
    @REM bcdedit /set {current} bootmenupolicy standard
)

taskkill /f /im explorer.exe

echo ɾ��������ϵͳ������
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /f /v "XRSYSAPI"
for /f "delims= " %%i in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /t REG_EXPAND_SZ ^| find /i "Unattend"') do reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v %%i /f
del /f /q "%SystemDrive%\Windows\System32\deploy.exe"
echo ɾ��װ����������
del /q /f "%SystemDrive%\Users\Public\Desktop\Internet Explorer.lnk"
del /q /f "%SystemDrive%\Users\Public\Desktop\��ַ����.lnk"
echo ��Ȼϵͳ������ʾ
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v legalnoticecaption /t REG_SZ /d "���棺����ϵͳ����û�в���������API��" /f
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v legalnoticetext /t REG_SZ /d "��ͨ�����������Ӳ��ȶ��������BUG���µģ����ڵ����ȷ������¼�˻��󣬷���http://url.xrgzs.top/osc���ء���������osc.exe���Խ��������ʾÿ�ε�¼ǰ����ǿ�Ƶ��������������������ϵQQ:2744460679�����" /f

cd /d "%~dp0"
echo Run
taskkill /f /im explorer.exe
for %%a in (Run\*.exe) do (
    echo [API]�������滷����Ӧ��%%a...>"%systemdrive%\Windows\Setup\wallname.txt"
    start "" /wait "%%a" /S
    del /f /q "%%a"
    taskkill /f /im explorer.exe
)
for %%a in (Run\*.msi) do (
    echo [API]�������滷����Ӧ��%%a...>"%systemdrive%\Windows\Setup\wallname.txt"
    start "" /wait "%%a" /passive /qb-! /norestart
    del /f /q "%%a"
    taskkill /f /im explorer.exe
)
for %%a in (Run\*.reg) do (
    echo [API]�������滷����Ӧ��%%a...>"%systemdrive%\Windows\Setup\wallname.txt"
    regedit /s "%%a"
    del /f /q "%%a"
)
taskkill /f /im explorer.exe
echo [API]����Ӧ��DIY�ӿ�api5_jzm.bat...>"%systemdrive%\Windows\Setup\wallname.txt"
if exist api5_jzm.bat call api5_jzm.bat
taskkill /f /im explorer.exe
if exist "%SystemDrive%\Windows\Setup\xrsyssearchapi.txt" (
    for %%a in (C D E F G H) do (
        if exist "%%a:\Xiaoran\API\api5_jzm.bat" (
            echo y | start "" /max /wait "%%a:\Xiaoran\API\api5_jzm.bat"
        )
        taskkill /f /im explorer.exe
        for %%b in (%%a:\Xiaoran\API\Run\*.exe) do (
            echo [API]�������滷����Ӧ��%%b...>"%systemdrive%\Windows\Setup\wallname.txt"
            start "" /wait "%%b" /S
            del /f /q "%%b"
            taskkill /f /im explorer.exe
        )
        for %%b in (%%a:\Xiaoran\API\Run\*.msi) do (
            echo [API]�������滷����Ӧ��%%b...>"%systemdrive%\Windows\Setup\wallname.txt"
            start "" /wait "%%b" /passive /qb-! /norestart
            del /f /q "%%b"
            taskkill /f /im explorer.exe
        )
        for %%b in (%%a:\Xiaoran\API\Run\*.reg) do (
            echo [API]�������滷����Ӧ��%%b...>"%systemdrive%\Windows\Setup\wallname.txt"
            regedit /s "%%b"
            del /f /q "%%b"
        )
    )
)
taskkill /f /im explorer.exe
echo [API]����Ӧ��OSCϵͳ�Ż����...>"%systemdrive%\Windows\Setup\wallname.txt"
start "" /wait "%~dp0osc\oscLoader.exe"
taskkill /f /im explorer.exe
echo waitosc
set oscstate=notok
if not exist "%SystemDrive%\Windows\Setup\oscstate.txt" (
    ping 127.0.0.1 -n 300 >nul
    if not exist "%SystemDrive%\Windows\Setup\oscstate.txt" (
        ping 127.0.0.1 -n 300 >nul
    )
)
echo [API]���ڴ�����������...>"%systemdrive%\Windows\Setup\wallname.txt"

if %osver% GEQ 3 (
    echo win8-11ϵͳWU��������
    start "" /wait /min "%~dp0apifiles\NSudoLC.exe" -U:T -P:E -wait regedit /s "%~dp0apifiles\WUdrivers-enable.reg"
    echo �ر���ʾ������ݽ��������ڵĹ��һ����֮����д���
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CloudExperienceHost\Intent\PersonalDataExport" /v PDEShown /t REG_DWORD /d 2 /f
    reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\CloudExperienceHost\Intent\PersonalDataExport" /v PDEShown /t REG_DWORD /d 2 /f
)

echo ��������
taskkill /f /im explorer.exe
regedit /s "%~dp0apifiles\cleanup.reg"
echo exit>"%systemdrive%\Windows\Setup\wallname.txt"
taskkill /f /im waller.exe
taskkill /f /im wall.exe
if exist "%~dp0apifiles\selfdel.bat" start "" "%~dp0apifiles\selfdel.bat"
shutdown /r /t 5 /c "ϵͳ������ɣ���������Ч��API��"
goto end

:end
exit