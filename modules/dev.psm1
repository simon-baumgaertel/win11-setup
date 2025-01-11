function Install-Font {
    Write-Output "[+] Installing JetBrains Mono Font via oh-my-posh ..."
    $ohMyPosh = "$env:LOCALAPPDATA\Programs\oh-my-posh\bin\oh-my-posh.exe"
    if(Get-Command $ohMyPosh -ErrorAction SilentlyContinue){
        try{
            Start-Process -FilePath $ohMyPosh -ArgumentList "font install JetBrainsMono" -Wait -NoNewWindow
        }catch{
            Write-Output "[?] oh-my-posh was not found :("
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
    
    <#
    # Visual Studio Code needs to be launched to create $env:APPDATA\Code
    # also settings.json needs to be created apparently
    if(-Not(Test-Path -Path "$env:APPDATA\Code\User")){

        
    }

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
    #>
    
}

function Set-POSHPrompt {
    $promptString = 'oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/unicorn.omp.json" | Invoke-Expression'

    if(-Not(Get-Path -Path $PROFILE)){
        New-Item -Path $PROFILE -Type File -Force
    }

    Add-Content -Path $PROFILE -Value $promptString
    . $PROFILE
}