function Set-TaskbarSettings {
    Write-Output "[i] Customizing Taskbar settings ..."

    # Default StartMenu alignment 0=Left
    Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name 'TaskbarAl' -Type "DWORD" -Value 0 -Force

    # Removes Task View from the Taskbar
    Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name "ShowTaskViewButton" -Type "DWORD" -Value "0" -Force
    
    # Removes Widgets from the Taskbar
    Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name "TaskbarDa" -Type "DWORD" -Value "0" -Force
    
    # Removes Chat from the Taskbar
    Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name "TaskbarMn" -Type "DWORD" -Value "0" -Force

    # Removes search from the Taskbar
    Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Search -Name "SearchboxTaskbarMode" -Type "DWORD" -Value "0" -Force

    # Unpin the Microsoft Store
    $msstore = "Microsoft Store" 
    ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $msstore}).Verbs() | ?{$_.Name.replace('&','') -match 'Unpin from taskbar'} | %{$_.DoIt(); $exec = $true}

    # Unpin the Copilot
    $copilot = "Copilot" 
    ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $copilot}).Verbs() | ?{$_.Name.replace('&','') -match 'Unpin from taskbar'} | %{$_.DoIt(); $exec = $true}
}

function Set-ExplorerSettings {
    Write-Output "[i] Customizing Explorer settings ..."
    
    # Show hidden files
    Set-ItemProperty -Path HKCU:\software\microsoft\windows\currentversion\explorer\advanced -Name "Hidden" -Type "DWORD" -Value "1" -Force

    # Show file extensions
    Set-ItemProperty -Path HKCU:\software\microsoft\windows\currentversion\explorer\advanced -Name "HideFileExt" -Type "DWORD" -Value "0" -Force

    # Launch Explorer to "This PC" instead of Home / Quick Access
    Set-ItemProperty -Path HKCU:\software\microsoft\windows\currentversion\explorer\advanced -Name "LaunchTo" -Type "DWORD" -Value "1" -Force

    # Remove OneDrive from Explorer
    #Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideOneDrive" -Value 1 -Force

    # Restore classic context menu
    $guid = "{86CA1AA0-34AA-4E8B-A509-50C905BAE2A2}" 
    New-Item -Path "HKCU:\Software\Classes\CLSID\" -Name $guid | Out-Null
    New-Item -Path "HKCU:\Software\Classes\CLSID\$guid" -Name InprocServer32 -Value "" | Out-Null 
}
function Set-DarkTheme {
    Write-Output "[i] Setting dark theme for system and apps ..."

    # set dark theme for apps and os (0 = dark, 1 = light)
    New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0 -Type Dword -Force | Out-Null
    New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0 -Type Dword -Force | Out-Null
}

function Disable-Tips{
    Write-Output "[-] Disabling lock screen tips ..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338387Enabled" -Type "DWORD" -Value "0"
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "RotatingLockScreenOverlayEnabled" -Type "DWORD" -Value "0"
}

function Remove-Shortcuts {
    Write-Output "[-] Removing desktops shortcuts ..."
    $desktops = @("C:\Users\Public\Desktop", "C:\Users\$env:USERNAME\Desktop")
    
    foreach ($desktop in $desktops){
        Get-ChildItem -Path $desktop -Filter "*.lnk" | Remove-Item -Force
    }
}