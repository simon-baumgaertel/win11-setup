# win11-setup

> [!NOTE]
> 🚧 This repo is a work in progress!

This repository contains a collection of personal scripts designed to streamline the setup process for Windows 11. 
The scripts automate various tasks such as system configuration, software installations and optimizations to enhance my Windows experience.

Feel free contribute or adapt the scripts to your personal needs!
 
## Usage

> [!CAUTION]
> ⚠️ Executing these scripts may modify system settings, install software, and apply configurations to your Windows 11 installation. Use these scripts at your own risk and ensure you have backups of important data. 

1. For a fresh install, download the [latest repo archive](https://github.com/simon-baumgaertel/win11-setup/archive/refs/heads/main.zip) & extract the archive

    * Change to your preferred directory and `Invoke-WebRequest https://github.com/simon-baumgaertel/win11-setup/archive/refs/heads/main.zip -OutFile scripts.zip;Expand-Archive -Path .\scripts.zip`

2. Change to the script directory `cd .\scripts\win11-setup-main\` & run the script in an **elevated** PowerShell (depending on your version used)
    * PowerShell 7+: `.\setup.ps1`
    * PowerShell <= 5: `powershell -ExecutionPolicy Bypass -File .\setup.ps1` 

## What's included

**⚙️ Applications**
* installs the latest [Windows Package Manager (WinGet)](https://github.com/microsoft/winget-cli)
    * installs some esential packages [essential_apps.csv](config/essential_apps.csv)
        * 7zip
        * Chromium
        * Firefox
        * KeePassXC
        * PowerShell
        * PowerToys
        * VisualStudioCode
        * WindowsTerminal
        * OhMyPosh
        * Notepad++
    * enables <ins>auto-updates</ins> on system startup for WinGet packages
* installs the [Windows Subsystem for Linux (WSL)](https://learn.microsoft.com/en-us/windows/wsl/install) _(Default Linux distribution is Ubuntu)_

**💩 Bloatware**
* removes common bloatware applications ([bloatware_apps.csv](config/bloatware_apps.csv))

**🧱 Telemetry**
* disables basic telemetry
* disables AI Recall
* disables Copilot
* disables Spotlight, Tips and Suggestions
* disables automatic app installs

**🛠️ Customization**
* sets taskbar settings
    * Start menu alignment to left
    * removes Task View from the Taskbar
    * removes Widgets from the Taskbar
    * removes Chat from the Taskbar
    * removes search from the Taskbar
* sets explorer settings
    * show hidden files
    * show file extensions
    * launch the Explorer to "This PC"
    * restore classic context menu
* disable lock screen tips
* removes shortcuts from applications on desktop
* <ins>Oh my Posh</ins>
    * install `JetBrains Mono` font
        * set as default font for Windows Terminal
        * change PowerShell prompt & sets the [unicorn](https://ohmyposh.dev/docs/themes#unicorn) theme

## Credits

* To [alec-hs/windows-11-setup](https://github.com/alec-hs/windows-11-setup) - for the good collection and the first idea for structuring my project.
* To [Raphire/Win11Debloat](https://github.com/Raphire/Win11Debloat) - for the detailed information regarding telemetry and bloatware

## License 

Distributed under the MIT License. See LICENSE.txt for more information.