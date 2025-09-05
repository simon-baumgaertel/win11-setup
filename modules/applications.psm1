function Update-WinGet {
    Write-Output "[+] Installing latest Windows Package Manager (WinGet)"
    Add-AppxPackage -Path "https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" -ForceApplicationShutdown
    try {
        winget --version
    }
    catch {
        Write-Output "[?] Having trouble to find WinGet ..."
    }
}

function Install-WinGetPackages {
    $packageList = ".\config\essential_apps.csv"
    if (Test-Path -Path $packageList) {
        $packages = Import-Csv -Path $packageList
        Write-Output "[i] Installing $($packages.count) packages"

        foreach ($package in $packages) {
            try {
                Write-Output "[+] Installing $($package.id)."
                winget install --id $package.id -e -s $package.source --accept-package-agreements --accept-source-agreements | Out-Null
            }
            catch {
                Write-Output "[-] Error installing $($package.id) - please verify package id"
            }
        }
    }
}

function Enable-AutoUpdates {
    $scheduledTask = Get-ScheduledTask | Where-Object TaskName -like "WinGet Auto-updates"
    if (!($scheduledTask)) {
        $trigger = New-ScheduledTaskTrigger -AtLogOn
        $action = New-ScheduledTaskAction -Execute "PowerShell" -Argument "winget upgrade --all --silent --accept-package-agreements --accept-source-agreements"
        Register-ScheduledTask -TaskName "WinGet Auto-updates" -Action $action -Trigger $trigger | Out-Null
        Write-Output "[+] Created a scheduled task to enable auto-updates via WinGet on system startup"
    }
}

function Install-WSL {
    wsl --install
}