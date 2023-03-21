# autPosh
This project deals with a script that can be used to configure the Windows terminal.

![Windows 10](https://img.shields.io/badge/Windows-10-3AADEF?style=flat-square&logo=windows&logoColor=white)
![PowerShell 7+](https://img.shields.io/badge/PowerShell-7+-131E2A?style=flat-square&logo=powershell&logoColor=white)

### README language
- 🇪🇸 [Spanish](./README.md)
- 🇺🇸 **English**

## Installation
1. Clone the repository on your system
    ```shell
    git clone https://github.com/Qv1ko/autPosh.git
    ```
2. Enter the autPosh directory
3. Execute in a PowerShell Terminal as administrator the command `Set-ExecutionPolicy Unrestricted`

## Usage
1. Run autPosh.ps1 script as administrator
2. Select an option:
    - Auto installation and configuration
    - Prompt theme selector
    - Uninstaller

## Manual configuration guide
1. Installing **Windows Terminal** and **PowerShell** from the Microsoft Store
2. Set **PowerShell** as **default** in Windows Terminal:
    1. Open Terminal
    2. Press `Ctrl`+`,` keys to open Windows Terminal settings
    3. In the "Startup" section, find the "Default Profile" option and set "PowerShell" as the value
3. **Install** a **font** for the PowerShell:
    1. Access the [NerdFonts](https://www.nerdfonts.com/font-downloads) website and choose a font
    2. Download the font by clicking on the `Download` button
    3. Unzip the downloaded file
    4. Open the font file
    5. Select all files excluding "LICENSE.txt" and "readme.md"
    6. Right click and select the "Install" option to install the font on your system
4. **Set** PowerShell **font** in Windows Terminal:
    1. Open Windows Terminal
    2. Press `Ctrl`+`,` keys to open Windows Terminal settings
    3. Access "Appearance" in the "Additional Settings" section of "PowerShell" in the "Profiles" section
    4. Set the installed font as the value in the "Font type" option
5. Installing **OhMyPosh**:
    1. Open Windows Terminal
    2. Type the command `Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))` to install OhMyPosh on the system
6. Choose theme for the **prompt** by accessing the [OhMyPosh](https://ohmyposh.dev/docs/themes) website
7. Create and edit PowerShell **configuration file**:
    1. Open Windows Terminal
    2. Type `New-Item -Path $PROFILE -Type File -Force` to create the PowerShell configuration file in the correct location
    3. Type `notepad $PROFILE` to open the file with notepad
    4. Add the following text to the file:
        ```txt
        oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\NombreTema.omp.json" | Invoke-Expression
        Import-Module -Name Terminal-Icons
        ```
    5. Replace "NombreTema" with the name of the topic chosen in the previous step
8. Install the files **icons module** by typing in Windows Terminal `Install-Module -Name Terminal-Icons -Repository PSGallery`
9. **Reload** PowerShell profile by typing in Windows Terminal the command `. $PROFILE`

**link to [Pastebin](https://pastebin.com/8dYnTyRw)**

## Credits
- [NerdFonts](https://www.nerdfonts.com) (Web of fonts)
- [Mononoki](https://github.com/madmalik/mononoki) (Project of the Mononoki font)
- [OhMyPosh](https://ohmyposh.dev) (Project of the prompt)
- [Terminal-Icons](https://github.com/devblackops/Terminal-Icons) (File and folder icons module project)
