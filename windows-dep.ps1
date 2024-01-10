Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))


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
choco install hyper

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

