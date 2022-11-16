#Administrator PowerShell
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

#Gloval variables
Write-Host "Options: `n  1) Installing `n  2) Updating `n  3) Exit"
$options=Read-Host "Select option"
$oldpath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
$terminalpath = Get-ChildItem -Path "$env:USERPROFILE\AppData\Local\Packages\" -Name "Microsoft.WindowsTerminal_*" -Directory
$jsonpath="$env:USERPROFILE\AppData\Local\Packages\$terminalpath\LocalState\settings.json"
$theme="catppuccin_macchiato"

#Function
switch ($options) {
    1 {
        $newpath = "$oldpath;$env:USERPROFILE\AppData\Local\Microsoft\WindowsApps\"
        Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newpath

        Write-Host "Install Windows Terminal and PowerShell"
        winget install --id=Microsoft.WindowsTerminal -e
        winget install --id Microsoft.Powershell --source winget
        
        Write-Host "Install Firacode font"
        Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        choco install firacode -y

        Write-Host "Terminal configuration"
        

        
        Write-Host "Install and configure OhMyPosh"
        winget install JanDeDobbeleer.OhMyPosh -s winget
        New-Item -Path $PROFILE -Type File -Force
        Start-Process "https://ohmyposh.dev/docs/themes"
        $theme=Read-Host "Write your favourite theme"
        Write-Output "oh-my-posh init pwsh --config `"$env:POSH_THEMES_PATH\$theme`.omp.json`" | Invoke-Expression`nImport-Module -Name Terminal-Icons" | Out-File $PROFILE
        . $PROFILE
        
        Write-Host "Install icons module"
        Install-PackageProvider NuGet -Force;
        Set-PSRepository PSGallery -InstallationPolicy Trusted
        Install-Module -Name Terminal-Icons -Repository PSGallery
        
        Clear-Host
        (Invoke-WebRequest "https://raw.githubusercontent.com/kiedtl/winfetch/master/winfetch.ps1" -UseBasicParsing).Content.Remove(0,1) | Invoke-Expression
        Start-Sleep(10)
    }
    2 {
        winget upgrade Microsoft.WindowsTerminal -s winget -h --accept-package-agreements --accept-source-agreements
        winget upgrade Microsoft.Powershell -s winget -h --accept-package-agreements --accept-source-agreements
        winget upgrade JanDeDobbeleer.OhMyPosh -s winget -h --accept-package-agreements --accept-source-agreements
    }
    3 {
        Write-Host "`nExit...`n"
    }
    Default {
        Write-Host "`n!Select valid option`n"
    }
}