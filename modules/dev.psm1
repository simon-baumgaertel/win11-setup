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
    # "C:\Users\<user>\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
    # "C:\Users\<user>\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
    # "C:\Users\<user>\Documents\PowerShell\Microsoft.VSCode_profile.ps1"
    $themePath = "$env:POSH_THEMES_PATH\tonybaloney.omp.json"
    $profileLine = "oh-my-posh init pwsh --config `"$themePath`" | Invoke-Expression"

    if (-not (Test-Path -Path $PROFILE)) {
        New-Item -Path $PROFILE -Type File -Force
    }

    # Prevent duplicate lines
    if (-not (Get-Content $PROFILE | Select-String -Pattern 'oh-my-posh init pwsh')) {
        Add-Content -Path $PROFILE -Value $profileLine
    }

    . $PROFILE
}