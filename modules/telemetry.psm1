# Bloatware
function Remove-Bloatware {
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

function Uninstall-OneDrive {
    Write-Output "[-] Removing OneDrive ..."
    $OneDriveSetup = "$env:SystemRoot\System32\OneDriveSetup.exe"
    Start-Process -FilePath $OneDriveSetup -ArgumentList "/uninstall"
}