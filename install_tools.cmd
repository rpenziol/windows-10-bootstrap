net session >nul 2>&1
if NOT %errorLevel% == 0 (
	echo Script must be run as Admin. Exiting.
	pause
	exit
)
PowerShell -Command Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
PowerShell -Command choco install 7zip.install -y
PowerShell -Command choco install agentransack -y
PowerShell -Command choco install git -y
PowerShell -Command choco install google-backup-and-sync -y
PowerShell -Command choco install googlechrome -y
PowerShell -Command choco install python3 -y
PowerShell -Command choco install retroarch -y
PowerShell -Command choco install revo-uninstaller -y
PowerShell -Command choco install steam-client -y
PowerShell -Command choco install synctrayzor -y
PowerShell -Command choco install vlc -y
PowerShell -Command choco install vscode -y
PowerShell -Command choco install windirstat -y
PowerShell -Command choco install winscp -y
pause
