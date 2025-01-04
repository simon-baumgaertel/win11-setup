
Function Set-TaskbarSettings {
    Write-Output "[i] Customizing Taskbar settings ..."

    # Default StartMenu alignment 0=Left
    Set-ItemProperty -Path HKCU:\software\microsoft\windows\currentversion\explorer\advanced -Name 'TaskbarAl' -Type 'DWord' -Value 0 -Force

    # Removes Task View from the Taskbar
    Set-ItemProperty -Path HKCU:\software\microsoft\windows\currentversion\explorer\advanced -Name "ShowTaskViewButton" -Type 'Dword' -Value "0" -Force
    
    # Removes Widgets from the Taskbar
    Set-ItemProperty -Path HKCU:\software\microsoft\windows\currentversion\explorer\advanced -Name "TaskbarDa" -Type 'Dword' -Value "0" -Force
    
    # Removes Chat from the Taskbar
    Set-ItemProperty -Path HKCU:\software\microsoft\windows\currentversion\explorer\advanced -Name "TaskbarMn" -Type 'Dword' -Value "0" -Force

    # Removes search from the Taskbar
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name "SearchboxTaskbarMode" -Type 'Dword' -Value "0" -Force
}

Function Set-ExplorerSettings {
    Write-Output "[i] Customizing Explorer settings ..."
    
    # Show hidden files
    Set-ItemProperty -Path HKCU:\software\microsoft\windows\currentversion\explorer\advanced -Name "Hidden" -Type 'Dword' -Value "1" -Force

    # Show file extensions
    Set-ItemProperty -Path HKCU:\software\microsoft\windows\currentversion\explorer\advanced -Name "HideFileExt" -Type 'Dword' -Value "0" -Force

    # Restore classic context menu
    $guid = "{86CA1AA0-34AA-4E8B-A509-50C905BAE2A2}" 
    New-Item -Path "HKCU:\Software\Classes\CLSID\" -Name $guid | Out-Null
    New-Item -Path "HKCU:\Software\Classes\CLSID\$guid" -Name InprocServer32 -Value "" | Out-Null 
}
Function Set-DarkTheme {
    Write-Output "[i] Setting dark theme for system and apps ..."

    # set dark theme for apps and os (0 = dark, 1 = light)
    New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0 -Type Dword -Force | Out-Null
    New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0 -Type Dword -Force | Out-Null
}

Function Remove-Shortcuts {
    Write-Output "[-] Removing desktops shortcuts ..."
    $desktops = @("C:\Users\Public\Desktop", "C:\Users\$env:USERNAME\Desktop")
    
    foreach ($desktop in $desktops){
        Get-ChildItem -Path $desktop -Filter "*.lnk" | Remove-Item -Force
    }
}