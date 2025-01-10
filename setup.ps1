#Requires -RunAsAdministrator
Import-Module ".\modules\basics.psm1" -Force
Import-Module ".\modules\applications.psm1" -Force
Import-Module ".\modules\customization.psm1" -Force
Import-Module ".\modules\dev.psm1" -Force
Import-Module ".\modules\telemetry.psm1" -Force

# Start
Start-Transcript -Path ".\Win11-Setup.log" -Force
Show-Welcome
Show-WindowsVersion

# Check for Windows 11
if (!(Test-Win11Installation)){ Write-Warning "This script is intended for Windows 11."; exit }

# Install apps and features
Update-WinGet
Install-WinGetPackages
Enable-AutoUpdates
Install-WSL

# Telemetry & Bloatware
Remove-Bloatware
Uninstall-OneDrive

# Customizations (dark theme, file extensiosn etc.)
Set-TaskbarSettings
Set-ExplorerSettings
Set-DarkTheme
Disable-Tips
Remove-Shortcuts
Restart-Explorer

# Dev
Install-Font
Set-Font

Stop-Transcript
Restart-System