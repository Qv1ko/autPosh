#Requires -Version 7.0

# Elevation of script privileges
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

#region Helper Functions

function Write-Header {
    Clear-Host
    Write-Host "`n autPosh - PowerShell Environment Setup`n" -ForegroundColor Cyan
}

function Get-MenuSelection {
    Write-Host "(1) Install" -ForegroundColor Green
    Write-Host "(2) Theme Selector" -ForegroundColor Yellow
    Write-Host "(3) Uninstall" -ForegroundColor Red
    Write-Host "(0) Exit`n" -ForegroundColor Gray

    $validOptions = @('0', '1', '2', '3')
    do {
        $selection = Read-Host "Select option"
        if ($selection -notin $validOptions) {
            Write-Host "`nPlease select a valid option`n" -ForegroundColor Red
        }
    } while ($selection -notin $validOptions)

    return [int]$selection
}

function Write-Status {
    param(
        [string]$Message,
        [ValidateSet('Info', 'Success', 'Warning', 'Error')]
        [string]$Type = 'Info'
    )

    $colors = @{
        Info    = 'White'
        Success = 'Green'
        Warning = 'Yellow'
        Error   = 'Red'
    }

    Write-Host "`n`t$Message`n" -ForegroundColor $colors[$Type]
}

function Install-Prerequisites {
    # PATH configuration
    Write-Status "Configuring PATH environment variable"
    $registryPath = "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment"
    $oldPath = (Get-ItemProperty -Path $registryPath -Name PATH).Path
    $windowsAppsPath = "$env:USERPROFILE\AppData\Local\Microsoft\WindowsApps\"

    if ($oldPath -notlike "*$windowsAppsPath*") {
        $newPath = "$oldPath;$windowsAppsPath"
        Set-ItemProperty -Path $registryPath -Name PATH -Value $newPath
    }

    # Winget installation
    if (!(Test-Path "$windowsAppsPath\winget.exe")) {
        Write-Status "Installing Windows Package Manager (winget)"
        Start-Process "ms-appinstaller:?source=https://aka.ms/getwinget"
        $installerProcess = Get-Process AppInstaller -ErrorAction SilentlyContinue
        if ($installerProcess) {
            Wait-Process -Id $installerProcess.Id
        }
    }

    # Windows Terminal installation
    if (!(Test-Path "$windowsAppsPath\wt.exe")) {
        Write-Status "Installing Windows Terminal"
        winget install --id=Microsoft.WindowsTerminal -e --accept-package-agreements --accept-source-agreements
    }

    # PowerShell installation
    if (!(Test-Path "$windowsAppsPath\pwsh.exe")) {
        Write-Status "Installing PowerShell 7"
        winget install --id Microsoft.Powershell --source winget --accept-package-agreements --accept-source-agreements
    }
}

function Install-NerdFont {
    Write-Status "Installing Mononoki Nerd Font"

    # Install Chocolatey if not present
    if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
        Set-ExecutionPolicy Bypass -Scope Process -Force
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://chocolatey.org/install.ps1"))
    }

    choco install nerd-fonts-mononoki -y
}

function Set-OhMyPoshTheme {
    Write-Status "Opening OhMyPosh themes gallery in browser"
    Start-Process "https://ohmyposh.dev/docs/themes"

    $themeName = Read-Host "`nEnter your favourite theme name"
    while ([string]::IsNullOrWhiteSpace($themeName)) {
        $themeName = Read-Host "Theme name cannot be empty. Enter your favourite theme name"
    }

    $profilePath = "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
    $profileContent = @"
oh-my-posh init pwsh --config "`$env:POSH_THEMES_PATH\$themeName.omp.json" | Invoke-Expression
Import-Module -Name Terminal-Icons
"@

    Set-Content -Path $profilePath -Value $profileContent -Force
    Write-Status "Theme '$themeName' configured successfully" -Type Success
}

function Install-OhMyPosh {
    Write-Status "Installing OhMyPosh"
    winget install JanDeDobbeleer.OhMyPosh -s winget

    # Create PowerShell profile if it doesn't exist
    $profilePath = "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
    if (!(Test-Path $profilePath)) {
        New-Item -Path $profilePath -ItemType File -Force | Out-Null
    }

    Set-OhMyPoshTheme
}

function Install-TerminalIcons {
    Write-Status "Installing Terminal Icons module"

    Install-PackageProvider NuGet -Force
    Set-PSRepository PSGallery -InstallationPolicy Trusted
    Install-Module -Name Terminal-Icons -Repository PSGallery -Force
}

function Invoke-FullInstall {
    Write-Header
    Write-Host "Starting full installation...`n" -ForegroundColor Cyan

    Install-Prerequisites
    Install-NerdFont

    # Copy Windows Terminal settings
    Write-Status "Configuring Windows Terminal"
    $settingsSource = Join-Path $PSScriptRoot "settings.json"
    $settingsDest = "$env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\"

    if (Test-Path $settingsSource) {
        Copy-Item -Path $settingsSource -Destination $settingsDest -Force
    } else {
        Write-Status "settings.json not found in script directory" -Type Warning
    }

    Install-OhMyPosh
    Install-TerminalIcons

    Write-Status "Installation completed successfully!" -Type Success
}

function Uninstall-AutPosh {
    Write-Header
    Write-Host "Starting uninstallation...`n" -ForegroundColor Cyan

    Write-Status "Removing OhMyPosh"
    winget uninstall JanDeDobbeleer.OhMyPosh -s winget

    $profilePath = "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
    if (Test-Path $profilePath) {
        Remove-Item -Path $profilePath -Force
    }

    Write-Status "Removing Mononoki Nerd Font"
    if (Get-Command choco -ErrorAction SilentlyContinue) {
        choco uninstall nerd-fonts-mononoki -y
    }

    Write-Status "Removing PowerShell 7"
    winget uninstall --id Microsoft.Powershell --source winget

    Write-Status "Removing Windows Terminal"
    winget uninstall --id=Microsoft.WindowsTerminal -e

    Write-Status "Uninstallation completed" -Type Success
}

do {
    Write-Header
    $selectedOption = Get-MenuSelection

    switch ($selectedOption) {
        1 {
            Invoke-FullInstall
        }
        2 {
            Set-OhMyPoshTheme
            Start-Process wt -ArgumentList "-w 0 nt -NoExit"
        }
        3 {
            Uninstall-AutPosh
        }
        0 {
            Write-Host "`nExiting..." -ForegroundColor Gray
            Start-Sleep -Seconds 2
        }
    }

    if ($selectedOption -ne 0) {
        Write-Host "`nPress any key to continue..."
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    }

} while ($selectedOption -ne 0)
