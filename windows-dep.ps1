# choco install
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# disable install confirmation
choco feature enable -n allowGlobalConfirmation

# utilities
choco install 7zip
choco install adobereader
choco install auto-dark-mode
choco install autoclicker
choco install ccleaner
choco install wiztree

# debugging exe files (if they are malicous)
choco install pestudio

# task manager on steroids
choco install procexp

# all startup processes
choco install autoruns

# dev related
choco install git
choco install teamviewer
choco install virtualbox
choco install vscode
choco install nodejs
choco install wezterm


# games
choco install bluestacks # android emulator
choco install cheatengine
choco install discord
choco install goggalaxy
choco install steam
choco install ubisoft-connect
choco install throttlestop
choco install vortex # nexus mod manager

## Browsers and Tools
choco install brave
choco install firefox
choco install driverbooster
choco install geforce-experience
choco install hxd # hex file editor
choco install kdeconnect-kde
choco install revo-uninstaller
choco install vlc # better media player


# Vim dependencies
choco install zig
choco install nerd-fonts-hack
choco install neovim


# Windows settings

# enable dev mode 
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowDevelopmentWithoutDevLicense" -Value 1

# disable "Show more options" feature (make Windows 11 show full menus right away)
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve

# always showing file extensions in file explorer
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v HideFileExt /t REG_DWORD /d 0 /f

# show hidden files in file explorer
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v Hidden /t REG_DWORD /d 1 /f

# windows open file explorer at this PC
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'LaunchTo' -Value 1

# Lazy Vim install
# required
Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak
# optional but recommended
Move-Item $env:LOCALAPPDATA\nvim-data $env:LOCALAPPDATA\nvim-data.bak
git clone https://github.com/LazyVim/starter $env:LOCALAPPDATA\nvim
Remove-Item $env:LOCALAPPDATA\nvim.git -Recurse -Force

# Run those after restarting terminal
# nvim
# Install parsers in Neovim via :TSInstall c, :TSInstall cpp
# :LazyExtras in neovim

