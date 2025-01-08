function Test-Win11Installation {
    (Get-WmiObject Win32_OperatingSystem).Caption -Match "Windows 11"
}

function Show-Welcome {
    Write-Output "_____________________________________________________"
    Write-Output "          _       _ _                _               "
    Write-Output "__      _(_)_ __ / / |      ___  ___| |_ _   _ _ __  "
    Write-Output "\ \ /\ / / | '_ \| | |_____/ __|/ _ \ __| | | | '_ \ "
    Write-Output " \ V  V /| | | | | | |_____\__ \  __/ |_| |_| | |_) |"
    Write-Output "  \_/\_/ |_|_| |_|_|_|     |___/\___|\__|\__,_| .__/ "
    Write-Output "                                              |_|    "
    Write-Output "     https://github.com/simon-baumgaertel/win11-setup"
}

function Show-WindowsVersion {
    $caption = (Get-CimInstance Win32_OperatingSystem).Caption
    $version = (Get-CimInstance Win32_OperatingSystem).Version
    $build = (Get-CimInstance Win32_OperatingSystem).BuildNumber
    $arch = (Get-CimInstance Win32_OperatingSystem).OSArchitecture

    Write-Output "_____________________________________________________"
    Write-Output "OS:           $caption"
    Write-Output "Version:      $version"
    Write-Output "Build:        $build"
    Write-Output "Architecture: $arch"
    Write-Output "_____________________________________________________"
}

function Restart-Explorer {
    Write-Output "[i] Restarting Explorer ..."
    Stop-Process -Name explorer -Force
}

function Restart-System {
    Write-Output "[i] Script has been executed. To apply all changes, the computer is restarted in 10 seconds."
    Start-Sleep -Seconds 10
    Restart-Computer -Force
}
