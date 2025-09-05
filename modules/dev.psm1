function Install-Font {
    Write-Output "[+] Installing JetBrains Mono Font via oh-my-posh ..."
    $ohMyPosh = "$env:LOCALAPPDATA\Programs\oh-my-posh\bin\oh-my-posh.exe"
    if (Get-Command $ohMyPosh -ErrorAction SilentlyContinue) {
        try {
            Start-Process -FilePath $ohMyPosh -ArgumentList "font install JetBrainsMono" -Wait -NoNewWindow
        }
        catch {
            Write-Output "[?] oh-my-posh was not found :("
        }
    }
    else {
        Write-Output "[?] oh-my-posh was not found :("
    }
}

function Set-Font {
    $desiredFont = "JetBrainsMono Nerd Font"

    # Windows Terminal
    $windowsTerminalConfig = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
    if (Test-Path -Path $WindowsTerminalConfig) {
        $desiredFont = "JetBrainsMono Nerd Font"

        $json = Get-Content -Path $WindowsTerminalConfig -Raw | ConvertFrom-Json
        $json.profiles.defaults | Add-Member -MemberType NoteProperty -Name font -Value @{ face = $desiredFont }

        $modifiedJsonContent = $json | ConvertTo-Json -Depth 5
        Set-Content -Path $WindowsTerminalConfig -Value $modifiedJsonContent

        Write-Output "[+] Set JetBrainsMono Nerd Font for Windows Terminal"
    }
    
}

function Set-POSHPrompt {
    $promptString = 'oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/unicorn.omp.json" | Invoke-Expression'

    if (-Not(Test-Path -Path $PROFILE)) {
        New-Item -Path $PROFILE -Type File -Force
    }

    Add-Content -Path $PROFILE -Value $promptString
    . $PROFILE
}