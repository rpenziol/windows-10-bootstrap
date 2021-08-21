@rem *** Disable Some Service ***
sc stop DiagTrack
sc stop diagnosticshub.standardcollector.service
sc stop dmwappushservice
sc stop WMPNetworkSvc
sc stop WSearch

sc config DiagTrack start= disabled
sc config diagnosticshub.standardcollector.service start= disabled
sc config dmwappushservice start= disabled
REM sc config RemoteRegistry start= disabled
REM sc config TrkWks start= disabled
sc config WMPNetworkSvc start= disabled
sc config WSearch start= disabled
REM sc config SysMain start= disabled

REM *** SCHEDULED TASKS tweaks ***
REM schtasks /Change /TN "Microsoft\Windows\AppID\SmartScreenSpecific" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Uploader" /Disable
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyUpload" /Disable
schtasks /Change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn" /Disable
schtasks /Change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack" /Disable
schtasks /Change /TN "Microsoft\Office\Office 15 Subscription Heartbeat" /Disable

REM schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable
REM schtasks /Change /TN "Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /Disable
REM schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable
REM schtasks /Change /TN "Microsoft\Windows\DiskFootprint\Diagnostics" /Disable *** Not sure if should be disabled, maybe related to S.M.A.R.T.
REM schtasks /Change /TN "Microsoft\Windows\FileHistory\File History (maintenance mode)" /Disable
REM schtasks /Change /TN "Microsoft\Windows\Maintenance\WinSAT" /Disable
REM schtasks /Change /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /Disable
REM schtasks /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /Disable
REM The stubborn task Microsoft\Windows\SettingSync\BackgroundUploadTask can be Disabled using a simple bit change. I use a REG file for that (attached to this post).
REM schtasks /Change /TN "Microsoft\Windows\Time Synchronization\ForceSynchronizeTime" /Disable
REM schtasks /Change /TN "Microsoft\Windows\Time Synchronization\SynchronizeTime" /Disable
REM schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable
REM schtasks /Change /TN "Microsoft\Windows\WindowsUpdate\Automatic App Update" /Disable


@rem *** Remove Telemetry & Data Collection ***
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MRT" /v DontOfferThroughWUAU /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /f

@REM Settings -> Privacy -> General -> Let apps use my advertising ID...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f
REM - SmartScreen Filter for Store Apps: Disable
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v EnableWebContentEvaluation /t REG_DWORD /d 0 /f
REM - Let websites provide locally...
reg add "HKEY_LOCAL_MACHINE\Control Panel\International\User Profile" /v HttpAcceptLanguageOptOut /t REG_DWORD /d 1 /f

@REM WiFi Sense: HotSpot Sharing: Disable
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v value /t REG_DWORD /d 0 /f
@REM WiFi Sense: Shared HotSpot Auto-Connect: Disable
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v value /t REG_DWORD /d 0 /f

@REM Change Windows Updates to "Notify to schedule restart"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v UxOption /t REG_DWORD /d 1 /f
@REM Disable P2P Update downlods outside of local network
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v DODownloadMode /t REG_DWORD /d 0 /f


REM *** Hide the search box from taskbar. You can still search by pressing the Win key and start typing what you're looking for ***
REM 0 = hide completely, 1 = show only icon, 2 = show long search box
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f

REM *** Disable MRU lists (jump lists) of XAML apps in Start Menu ***
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f

REM *** Set Windows Explorer to start on This PC instead of Quick Access ***
REM 1 = This PC, 2 = Quick access
REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f

@rem Remove Apps
PowerShell -Command "Get-AppxPackage -allusers *3DBuilder* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *ACGMediaPlayer* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *ActiproSoftwareLLC* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *AdobePhotoshopExpress* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *AdobePhotoshopExpress* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Advertising.Xaml* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Advertising.Xaml* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Advertising.Xaml* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *AppConnector* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Asphalt8Airborne* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *AutodeskSketchBook* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *BingFinance* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *BingNews* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *BingSports* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *BingTranslator* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *BingWeather* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *BubbleWitch3Saga* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *CandyCrush* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *CyberLinkMediaSuiteEssentials* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *DisneyMagicKingdoms* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *DrawboardPDF* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Duolingo-LearnLanguagesforFree* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *EclipseManager* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Facebook* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *FarmVille2CountryEscape* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Flipboard* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *GetHelp* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Getstarted* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *HiddenCity* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *HiddenCityMysteryofShadows* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Hulu* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Keeper* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Lens* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *LinkedInforWindows* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *MarchofEmpires* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Messaging* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Microsoft.MSPaint* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Microsoft3DViewer* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *MicrosoftOfficeHub* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *MicrosoftOfficeHub* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *MicrosoftPowerBIForWindows* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *MicrosoftSolitaireCollection* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *MicrosoftStickyNotes* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *MixedReality.Portal* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Netflix* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *NetworkSpeedTest* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *OneCalendar* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *OneConnect* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *OneNote* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *PandoraMediaInc* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *People* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Plex* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Print3D* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *RemoteDesktop* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Roblox* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *RoyalRevolt* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *RoyalRevolt2* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *ScreenSketch* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *SkypeApp* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *SolitaireCollection* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *SpeedTest* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *SpotifyMusic* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Sway* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Sway* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Twitter* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Viber* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Wallet* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Whiteboard* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *WinZipUniversal* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *WindowsAlarms* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *WindowsFeedbackHub* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *WindowsMaps* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *WindowsPhone* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *WindowsSoundRecorder* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Wunderlist* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *XING* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *YourPhone* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *windowscommunicationsapps* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers Microsoft.549981C3F5F1 | Remove-AppxPackage"

@rem NOW JUST SOME TWEAKS
REM *** Show hidden files in Explorer ***
REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d 1 /f

REM *** Show super hidden system files in Explorer ***
REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSuperHidden" /t REG_DWORD /d 1 /f

REM *** Show file extensions in Explorer ***
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t  REG_DWORD /d 0 /f

REM *** Disable Bing Cortona search ***
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /f /v "AllowSearchToUseLocation" /t REG_DWORD /d 0
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /f /v "BingSearchEnabled" /t REG_DWORD /d 0
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /f /v "CortanaConsent" /t REG_DWORD /d 0

REM *** Disable lock screen 'Get fun facts, tips, tricks and more' ***
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /f /v "ContentDeliveryAllowed" /t REG_DWORD /d 0
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /f /v "RotatingLockScreenEnabled" /t REG_DWORD /d 0
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /f /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d 0
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /f /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /f /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /f /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d 0
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /f /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /f /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /f /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /f /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /f /v "SubscribedContent-353698Enabled" /t REG_DWORD /d 0
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /f /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\CloudContent" /f /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1

REM *** Combine taskbar buttons ***
REM 0 = Always, 1 = When Taskbar is Full, 2 = Never
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarGlomLevel" /t REG_DWORD /d 2 /f

REM *** Remove Microsoft Edge taskbar shortcut ***
PowerShell -Command "((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq 'Microsoft Edge'}).Verbs() | ?{$_.Name.replace('&','') -match 'Unpin from taskbar'} | %{$_.DoIt(); $exec = $true}"

REM *** Remove Microsoft Store taskbar shortcut ***
PowerShell -Command "((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq 'Microsoft Store'}).Verbs() | ?{$_.Name.replace('&','') -match 'Unpin from taskbar'} | %{$_.DoIt(); $exec = $true}"

REM *** Remove Cortana Button taskbar shortcut ***
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCortanaButton" /t REG_DWORD /d 0 /f

REM *** Allow SMB share access with no authentication ***
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "AllowInsecureGuestAuth" /t REG_DWORD /d 1 /f

REM *** Disable Task View Button ***
REG add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d 0 /f

REM *** Disable Weather and News taskbar icon ***
REG add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Feeds" /v "ShellFeedsTaskbarViewMode" /t REG_DWORD /d 2 /f

REM *** Disable Meet Now button ***
REG add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideSCAMeetNow" /t REG_DWORD /d 1 /f

REM *** Disable Action Center ***
REG add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter " /t REG_DWORD /d 1 /f

REM *** POWER OPTIONS ***
REM *** Set 'Ultimate Performance' power scheme ***
for /f "tokens=4" %g in ('powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61') do set GUID=%g
powercfg /setactive %GUID%

REM *** Display never turns off ***
powercfg -change -monitor-timeout-ac 0

REM *** Uninstall OneDrive ***
start /wait "" "%SYSTEMROOT%\SYSWOW64\ONEDRIVESETUP.EXE" /UNINSTALL
rd C:\OneDriveTemp /Q /S >NUL 2>&1
rd "%USERPROFILE%\OneDrive" /Q /S >NUL 2>&1
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /Q /S >NUL 2>&1
rd "%PROGRAMDATA%\Microsoft OneDrive" /Q /S >NUL 2>&1
reg add "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /f /v Attributes /t REG_DWORD /d 0 >NUL 2>&1
reg add "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /f /v Attributes /t REG_DWORD /d 0 >NUL 2>&1
echo OneDrive has been removed. Windows Explorer needs to be restarted.
pause

start /wait TASKKILL /f /IM explorer.exe
start explorer.exe
