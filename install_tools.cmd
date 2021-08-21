net session >nul 2>&1
if NOT %errorLevel% == 0 (
	echo Script must be run as Admin. Exiting.
	pause
	exit
)

PowerShell -Command Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
PowerShell -Command C:\ProgramData\chocolatey\bin\choco.exe install 7zip.install -y
PowerShell -Command C:\ProgramData\chocolatey\bin\choco.exe install agentransack -y
PowerShell -Command C:\ProgramData\chocolatey\bin\choco.exe install chocolateypackageupdater -y
PowerShell -Command C:\ProgramData\chocolatey\bin\choco.exe install git -y
PowerShell -Command C:\ProgramData\chocolatey\bin\choco.exe install google-backup-and-sync -y
PowerShell -Command C:\ProgramData\chocolatey\bin\choco.exe install googlechrome -y
PowerShell -Command C:\ProgramData\chocolatey\bin\choco.exe install python3 -y
PowerShell -Command C:\ProgramData\chocolatey\bin\choco.exe install retroarch -y
PowerShell -Command C:\ProgramData\chocolatey\bin\choco.exe install revo-uninstaller -y
PowerShell -Command C:\ProgramData\chocolatey\bin\choco.exe install steam-client -y
PowerShell -Command C:\ProgramData\chocolatey\bin\choco.exe install synctrayzor -y
PowerShell -Command C:\ProgramData\chocolatey\bin\choco.exe install vlc -y
PowerShell -Command C:\ProgramData\chocolatey\bin\choco.exe install vscode -y
PowerShell -Command C:\ProgramData\chocolatey\bin\choco.exe install windirstat -y
PowerShell -Command C:\ProgramData\chocolatey\bin\choco.exe install winscp -y

PowerShell -Command "Add-WindowsCapability -Online -Name (Get-WindowsCapability -Online | ? Name -like 'OpenSSH.Server*').Name"
sc start sshd
sc config sshd start=auto

pause
