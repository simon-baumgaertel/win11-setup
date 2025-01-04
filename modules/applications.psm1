Function Update-WinGet {
    Write-Output "[+] Installing latest Windows Package Manager (WinGet)"
    Add-AppxPackage -Path "https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" -ForceApplicationShutdown
    try {
        winget --version
    } catch {
    Write-Output "[?] Having trouble to find WinGet ..."
    }
}

Function Install-WinGetPackages {
    $packageList = ".\config\winget_apps.csv"
    if(Test-Path -Path $packageList){
        $packages = Import-Csv -Path $packageList
        Write-Output "[+] Installing $($packages.count) packages"

        foreach ($package in $packages) {
            try {
		        winget install --id $package.id -e -s $package.source --accept-package-agreements --accept-source-agreements
            } catch {
                Write-Output "[-] Error installing $package - please verify package id"
            }
        }
    }
}

Function Install-WSL {
    wsl --install
}

Function Remove-Bloatware {
    $bloatware = ".\config\bloatware_apps.csv"
    if(Test-Path -Path $bloatware){
        $apps = Import-Csv -Path $bloatware
        Write-Output "[-] Removing $($apps.count) bloatware apps"

        foreach ($app in $apps) {
            try {
                Get-AppxPackage -AllUsers $app.id | Remove-AppxPackage -AllUsers -Verbose -ErrorAction Continue
            } catch {
                Write-Output "[?] An error occured while removing $app.id"
            }
        }
    }
}