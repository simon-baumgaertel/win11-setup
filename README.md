# win11-setup

> [!NOTE]
> This repo is a work in progress!

This repository contains a collection of personal scripts designed to streamline the setup process for Windows 11. 
The scripts automate various tasks such as system configuration, software installations and optimizations to enhance my Windows experience.

> [!CAUTION]
> Executing these scripts may modify system settings, install software, and apply configurations to your Windows 11 installation. Use these scripts at your own risk and ensure you have backups of important data. 

Feel free to explore, contribute, or adapt the scripts to your personal needs!

## Usage

1. For a fresh install, download the [latest repo archive](https://github.com/simon-baumgaertel/win11-setup/archive/refs/heads/main.zip) & extract the archive

2. Run the script in an *elevated* PowerShell (depending on your version used)
    * PowerShell 7+: `.\setup.ps1`
    * PowerShell <= 5: `powershell -ExecutionPolicy Bypass -File .\setup.ps1` 

## What's included

**Applications**
* installs the latest [Windows Package Manager (WinGet)](https://github.com/microsoft/winget-cli)
    * installs all package ids in [winget_apps.csv](winget_apps.csv)
        * Installs by default the applications: `7-zip, Firefox, Chromium, Notepad++, Visual Studio Code, KeePassXC, PowerShell Core, PowerToys, Windows Terminal, Joplin, Bruno, Discord, Steam, PrismLauncher, Microsoft OpenJDK and PhpStorm`
* installs the [Windows Subsystem for Linux (WSL)](https://learn.microsoft.com/en-us/windows/wsl/install) _(Default Linux distribution is Ubuntu)_

**Customization**
* sets taskbar settings
    * Start menu alignment to left
    * removes Task View from the Taskbar
    * removes Widgets from the Taskbar
    * removes Chat from the Taskbar
    * removes search from the Taskbar
* sets explorer settings
    * show hidden files
    * show file extensions
    * restore classic context menu
* removes shortcuts from applications on desktop

## Credits

* To [alec-hs/windows-11-setup](https://github.com/alec-hs/windows-11-setup) - for the good collection and the first idea for structuring the project.

## License 

Distributed under the MIT License. See LICENSE.txt for more information.