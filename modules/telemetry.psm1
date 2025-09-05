# Bloatware
function Remove-Bloatware {
    $bloatware = ".\config\bloatware_apps.csv"
    if (Test-Path -Path $bloatware) {
        $apps = Import-Csv -Path $bloatware
        Write-Output "[i] Removing $($apps.count) bloatware apps"

        foreach ($app in $apps) {
            try {
                Write-Output "[-] Removing $($app.id)"
                Get-AppxPackage -AllUsers $app.id | Remove-AppxPackage -AllUsers -Verbose -ErrorAction Continue
            }
            catch {
                Write-Output "[?] An error occured while removing $app.id"
            }
        }
    }
}

function Uninstall-OneDrive {
    Write-Output "[-] Removing OneDrive ..."
    $OneDriveSetup = "$env:SystemRoot\System32\OneDriveSetup.exe"
    Start-Process -FilePath $OneDriveSetup -ArgumentList "/uninstall"
}

function Disable-Telemetry {
    Write-Output "[i] Disabling AI Recall ..."
    $regFile = ".\registry_files\Disable_AIRecall.reg"
    try {
        Start-Process regedit.exe -ArgumentList "/s", $regFile -Wait -ErrorAction SilentlyContinue
    }
    catch {
        Write-Output "Failed to apply $regFile. Error: $_"
    }

    Write-Output "[i] Disabling Copilot ..."
    $regFile = ".\registry_files\Disable_Copilot.reg"
    try {
        Start-Process regedit.exe -ArgumentList "/s", $regFile -Wait -ErrorAction SilentlyContinue
    }
    catch {
        Write-Output "Failed to apply $regFile. Error: $_"
    }

    Write-Output "[i] Disabling Spotlight & Tips ..."
    $regFile = ".\registry_files\Disable_Spotlight_Tips.reg"
    try {
        Start-Process regedit.exe -ArgumentList "/s", $regFile -Wait -ErrorAction SilentlyContinue
    }
    catch {
        Write-Output "Failed to apply $regFile. Error: $_"
    }

    Write-Output "[i] Disabling Windows Suggestions ..."
    $regFile = ".\registry_files\Disable_Windows_Suggestions.reg"
    try {
        Start-Process regedit.exe -ArgumentList "/s", $regFile -Wait -ErrorAction SilentlyContinue
    }
    catch {
        Write-Output "Failed to apply $regFile. Error: $_"
    }

    Write-Output "[i] Disabling telemetry ..."
    $regFile = ".\registry_files\Disable_Telemetry.reg"
    try {
        Start-Process regedit.exe -ArgumentList "/s", $regFile -Wait -ErrorAction SilentlyContinue
    }
    catch {
        Write-Output "Failed to apply $regFile. Error: $_"
    }
}