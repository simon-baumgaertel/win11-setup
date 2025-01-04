Function Test-Win11Installation {
    (Get-WmiObject Win32_OperatingSystem).Caption -Match "Windows 11"
}

Function Restart-Explorer {
    Write-Output "[i] Restarting Explorer ..."
    Stop-Process -Name explorer -Force
}