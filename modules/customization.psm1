function Edit-TaskbarExplorer {
    Write-Output "[i] Customizing Taskbar settings ..."
    $regFile = ".\registry_files\Customize_Explorer_Taskbar.reg"
    try {
        Start-Process regedit.exe -ArgumentList "/s", $regFile -Wait -ErrorAction SilentlyContinue
    }
    catch {
        Write-Output "Failed to apply $regFile. Error: $_"
    }

    Write-Output "[-] Removing Widgets ..."
    $regFile = ".\registry_files\Disable_Widgets_Taskbar.reg"
    try {
        Start-Process regedit.exe -ArgumentList "/s", $regFile -Wait -ErrorAction SilentlyContinue
    }
    catch {
        Write-Output "Failed to apply $regFile. Error: $_"
    }

    Write-Output "[-] Disbaling Bing and Cortana Search ..."
    $regFile = ".\registry_files\Disable_Bing_Cortana_Search.reg"
    try {
        Start-Process regedit.exe -ArgumentList "/s", $regFile -Wait -ErrorAction SilentlyContinue
    }
    catch {
        Write-Output "Failed to apply $regFile. Error: $_"
    }
}

function Set-DarkTheme {
    Write-Output "[i] Setting dark theme for system and apps ..."

    $regFile = ".\registry_files\Set_DarkTheme.reg"
    try {
        Start-Process regedit.exe -ArgumentList "/s", $regFile -Wait -ErrorAction SilentlyContinue
    }
    catch {
        Write-Output "Failed to apply $regFile. Error: $_"
    }
}

function Remove-Shortcuts {
    Write-Output "[-] Removing desktops shortcuts ..."
    $desktops = @("C:\Users\Public\Desktop", "C:\Users\$env:USERNAME\Desktop")
    
    foreach ($desktop in $desktops) {
        Get-ChildItem -Path $desktop -Filter "*.lnk" | Remove-Item -Force
    }
}

function Set-PowerPlan {

    # Power Scheme GUID: 381b4222-f694-41f0-9685-ff5bb260df2e  (Balanced)
    # Power Scheme GUID: 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c  (High performance)
    # Power Scheme GUID: a1841308-3541-4fab-bc81-f71556f20b4a  (Power saver)
    $powerPlanGUID = "8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c"

    if (Get-Command "powercfg.exe") {
        Write-Output "[i] Set HIGH PERFORMANCE Power Setting"
        powercfg.exe -s $powerPlanGUID
    }

}