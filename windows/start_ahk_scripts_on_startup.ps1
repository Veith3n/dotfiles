# Define the path to your AHK script
$ahkScriptPath = "C:\Users\$env:USERNAME\Desktop\ctrl+backspace=delete.ahk"

# Locate AutoHotkey installation path from the registry
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\AutoHotkey.exe"
$ahkExePath = (Get-ItemProperty -Path $registryPath).'(default)'

if (-not $ahkExePath) {
    Write-Host "AutoHotkey is not installed or not found in the registry."
    exit
}

# Define the path for the shortcut
$shortcutPath = [System.IO.Path]::Combine($env:APPDATA, "Microsoft\Windows\Start Menu\Programs\Startup", "ctrl+backspace=delete.lnk")

# Create a WScript.Shell COM object
$shell = New-Object -ComObject WScript.Shell

# Create the shortcut
$shortcut = $shell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $ahkExePath # Use the dynamically found path
$shortcut.Arguments = "`"$ahkScriptPath`"" # Path to your AHK script
$shortcut.Save()

Write-Host "Shortcut created in Startup folder."
