net session >nul 2>&1
if NOT %errorLevel% == 0 (
	echo Script must be run as Admin. Exiting.
	pause
	exit
)

@REM Install Chocolatey package manager
PowerShell -Command Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

@REM Install packages using Chocolatey
C:\ProgramData\chocolatey\bin\choco.exe install -y ^
agentransack ^
audacity ^
coretemp ^
crystaldiskinfo ^
crystaldiskmark ^
discord ^
eartrumpet ^
ffmpeg ^
Firefox ^
foxitreader ^
gimagereader ^
git ^
googleearthpro ^
handbrake ^
hwinfo ^
InkScape ^
lossless-cut ^
microsoft-windows-terminal ^
mkvtoolnix ^
nomacs ^
obs-studio ^
postman ^
python3 ^
renamer ^
rufus ^
signal ^
sqlitebrowser ^
steam ^
synctrayzor ^
sysinternals ^
tagscanner ^
thunderbird ^
veracrypt ^
vlc ^
vscode ^
win32diskimager ^
windirstat ^
winscp

@REM Install Windows Subsystem for Linux (WSL)
wsl --install

@REM Install OpenSSH Server, enable and start OpenSSH Server service
PowerShell -Command "Add-WindowsCapability -Online -Name (Get-WindowsCapability -Online | ? Name -like 'OpenSSH.Server*').Name"
sc start sshd
sc config sshd start=auto

pause
