Function Update-WinGet {
    Write-Output "[+] Installing latest Windows Package Manager (WinGet)"
    Add-AppxPackage -Path "https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" -ForceApplicationShutdown
    try {
        winget --version
    } catch {
        Write-Output "[-] Having trouble to verify WinGet presence ..."
    }
}

Function Install-WSL {
    Write-Output "[+] Installing WSL (Ubuntu)"
    wsl --install
}