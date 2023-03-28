Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))


choco install wiztree
choco install steam
choco install vscode
choco install git
choco install firefox
choco install brave
choco install hyper
choco install discord
choco install ccleaner
choco install goggalaxy
choco install ubisoft-connect
choco install revo-uninstaller
choco install driverbooster
choco install teamviewer
choco install virtualbox
choco install hxd

# debugging exe files (if they are malicous)
choco install pestudio

# task manager on steroids
choco install procexp

# all startup processes
choco install autoruns
