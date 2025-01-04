
Function Set-TaskbarSettings {
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
    # Show hidden files
    Set-ItemProperty -Path HKCU:\software\microsoft\windows\currentversion\explorer\advanced -Name "Hidden" -Type 'Dword' -Value "1" -Force

    # Show file extensions
    Set-ItemProperty -Path HKCU:\software\microsoft\windows\currentversion\explorer\advanced -Name "HideFileExt" -Type 'Dword' -Value "0" -Force
}
Function Set-DarkTheme {
    # set dark theme for apps and os
    New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0 -Type Dword -Force
    New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0 -Type Dword -Force
}
