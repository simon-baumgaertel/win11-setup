function Install-Font {
    Write-Output "[+] Installing JetBrains Mono Font via oh-my-posh ..."
    if(Get-Command "oh-my-posh.exe"){
        try{
            Start-Process -FilePath "oh-my-posh.exe" -ArgumentList "font install JetBrainsMono" -Wait -NoNewWindow
        }catch{
    
        }
    }else{
        Write-Output "[?] oh-my-posh was not found :("
    }
}

function Set-Font{
    $desiredFont = "JetBrainsMono Nerd Font"

    # Windows Terminal
    $windowsTerminalConfig = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
    if(Test-Path -Path $WindowsTerminalConfig){
        $desiredFont = "JetBrainsMono Nerd Font"

        $json = Get-Content -Path $WindowsTerminalConfig -Raw | ConvertFrom-Json
        $json.profiles.defaults | Add-Member -MemberType NoteProperty -Name font -Value @{ face = $desiredFont }

        $modifiedJsonContent = $json | ConvertTo-Json -Depth 5
        Set-Content -Path $WindowsTerminalConfig -Value $modifiedJsonContent

        Write-Output "[+] Set JetBrainsMono Nerd Font for Windows Terminal"
    }
    
    # Visual Studio Code
    $vsCodeConfig = "$env:APPDATA\Code\User\settings.json"
    if(Test-Path -Path $vsCodeConfig){
        $json = Get-Content -Path  $vsCodeConfig -Raw | ConvertFrom-Json

        if (-not $json.PSObject.Properties['editor']) {
            $json | Add-Member -MemberType NoteProperty -Name editor -Value @{}
        }
        $json.editor.fontFamily = $desiredFont

        $modifiedJsonContent = $json | ConvertTo-Json -Depth 5
        Set-Content -Path $vsCodeConfig -Value $modifiedJsonContent

        Write-Output "[+] Set JetBrainsMono Nerd Font for Visual Studio Code"
    }
}