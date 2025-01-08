#Requires -RunAsAdministrator
Start-Transcript -Path ".\Win11-Setup.log" -Force
Show-Welcome
Show-WindowsVersion

Write-Output "[i] Importing modules ..."
Import-Module ".\modules\applications.psm1" -Force
Import-Module ".\modules\basics.psm1" -Force
Import-Module ".\modules\customization.psm1" -Force

# Check for Windows 11
if (!(Test-Win11Installation)) { Write-Warning "This script is intended for Windows 11."; exit}

# Install apps and features
Update-WinGet
Install-WinGetPackages
Enable-AutoUpdates
Install-WSL

# Customizations (dark theme, file extensiosn etc.)
Set-TaskbarSettings
Set-ExplorerSettings
Set-DarkTheme
Remove-Shortcuts
Restart-Explorer

Stop-Transcript
Restart-System