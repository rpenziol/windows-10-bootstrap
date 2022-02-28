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
calibre ^
coretemp ^
crystaldiskinfo ^
crystaldiskmark ^
discord ^
docker-desktop ^
eartrumpet ^
ffmpeg ^
Firefox ^
foobar2000 ^
foxitreader ^
git ^
googleearthpro ^
handbrake ^
hwinfo ^
InkScape ^
iTunes ^
libreoffice-fresh ^
lossless-audio-checker ^
lossless-cut ^
meld ^
microsoft-windows-terminal ^
mkvtoolnix ^
nomacs ^
obs-studio ^
postman ^
python3 ^
renamer ^
retroarch ^
rufus ^
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
winscp ^
wsl-ubuntu-2004 ^
wsl2

@REM Install OpenSSH Server, enable and start OpenSSH Server service
PowerShell -Command "Add-WindowsCapability -Online -Name (Get-WindowsCapability -Online | ? Name -like 'OpenSSH.Server*').Name"
sc start sshd
sc config sshd start=auto

pause
