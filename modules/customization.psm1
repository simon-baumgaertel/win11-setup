function Edit-TaskbarExplorer {
    Write-Output "[i] Customizing Taskbar settings ..."
    $regFile = ".\registry_files\Customize_Explorer_Taskbar.reg"
    try {
        Start-Process regedit.exe -ArgumentList "/s", $regFile -Wait -ErrorAction SilentlyContinue
    } catch {
        Write-Output "Failed to apply $regFile. Error: $_"
    }

    Write-Output "[-] Removing Widgets ..."
    $regFile = ".\registry_files\Disable_Widgets_Taskbar.reg"
    try {
        Start-Process regedit.exe -ArgumentList "/s", $regFile -Wait -ErrorAction SilentlyContinue
    } catch {
        Write-Output "Failed to apply $regFile. Error: $_"
    }

    Write-Output "[-] Disbaling Bing and Cortana Search ..."
    $regFile = ".\registry_files\Disable_Bing_Cortana_Search.reg"
    try {
        Start-Process regedit.exe -ArgumentList "/s", $regFile -Wait -ErrorAction SilentlyContinue
    } catch {
        Write-Output "Failed to apply $regFile. Error: $_"
    }
}

function Set-DarkTheme {
    Write-Output "[i] Setting dark theme for system and apps ..."

    # set dark theme for apps and os (0 = dark, 1 = light)
    New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0 -Type Dword -Force | Out-Null
    New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0 -Type Dword -Force | Out-Null
}



function Remove-Shortcuts {
    Write-Output "[-] Removing desktops shortcuts ..."
    $desktops = @("C:\Users\Public\Desktop", "C:\Users\$env:USERNAME\Desktop")
    
    foreach ($desktop in $desktops){
        Get-ChildItem -Path $desktop -Filter "*.lnk" | Remove-Item -Force
    }
}