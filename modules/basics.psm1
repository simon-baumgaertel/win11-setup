Function Test-Win11Installation {
    (Get-WmiObject Win32_OperatingSystem).Caption -Match "Windows 11"
}

Function Restart-Explorer {
    Write-Output "[i] Restarting Explorer ..."
    Stop-Process -Name explorer -Force
}

Fuction Restart-System {
    Write-Output "[i] Script has been executed. To apply all changes, the computer is restarted in 10 seconds."
    Start-Sleep -Seconds 10
    Restart-Computer -Force
}