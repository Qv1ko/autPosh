#Elevation of script privileges
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

$Option=Read-Host "(1) Install, (2) Theme selector`nSelect option"
if($Option -eq 1) {
    #Path configuration
    $OldPath = (Get-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment" -Name PATH).path
    $NewPath = "$OldPath;$env:USERPROFILE\AppData\Local\Microsoft\WindowsApps\"
    Set-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment" -Name PATH -Value $NewPath
    #Winget install condition
    if (!(Test-Path "$env:USERPROFILE\AppData\Local\Microsoft\WindowsApps\winget.exe")) {
        Write-Host "`n`n`Winget installation`n"
        Start-Process "ms-appinstaller:?source=https://aka.ms/getwinget"
        $InstallId = (Get-Process AppInstaller).Id
        Wait-Process -Id $InstallId
    }
    #Windows terminal install condition
    if (!(Test-Path "$env:USERPROFILE\AppData\Local\Microsoft\WindowsApps\wt.exe")) {
        Write-Host "`n`n`tWindows Terminal installation`n"
        winget install --id=Microsoft.WindowsTerminal -e --accept-package-agreements --accept-source-agreements
    }
    #Powershell install condition
    if (!(Test-Path "$env:USERPROFILE\AppData\Local\Microsoft\WindowsApps\pwsh.exe")) {
        Write-Host "`n`n`tPowerShell installation`n"
        winget install --id Microsoft.Powershell --source winget --accept-package-agreements --accept-source-agreements
    }
    #Terminal font installation
    Write-Host "`n`n`tMononoki font installation`n"
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://chocolatey.org/install.ps1"))
    choco install nerd-fonts-mononoki -y
    #Terminal configuration
    Write-Host "`n`n`tTerminal configuration`n"
    Copy-Item -Path "$PSCommandPath\..\settings.json" -Destination "$env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\" -Force
    #OhMyPosh configuration and installation
    Write-Host "`n`n`tOhMyPosh installation and configuration`n"
    winget install JanDeDobbeleer.OhMyPosh -s winget
    New-Item -Path "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -ItemType File -Force
    Start-Process "https://ohmyposh.dev/docs/themes"
    $PoshTheme=Read-Host "`nWrite your favourite theme"
    Write-Output "oh-my-posh init pwsh --config `"`$env:POSH_THEMES_PATH\$PoshTheme.omp.json`" | Invoke-Expression`nImport-Module -Name Terminal-Icons" | Out-File "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
    #Icons module installation
    Write-Host "`n`n`tIcon module installation`n"
    Install-PackageProvider NuGet -Force
    Set-PSRepository PSGallery -InstallationPolicy Trusted
    Install-Module -Name Terminal-Icons -Repository PSGallery
    #Exit
    . $PROFILE
    wt -w 0 nt -NoExit
} elseif($Option -eq 2) {
    #OhMyPosh theme configuration
    Start-Process "https://ohmyposh.dev/docs/themes"
    $PoshTheme=Read-Host "`nWrite your favourite theme"
    Write-Output "oh-my-posh init pwsh --config `"`$env:POSH_THEMES_PATH\$PoshTheme.omp.json`" | Invoke-Expression`nImport-Module -Name Terminal-Icons" | Out-File "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
    wt -w 0 nt -NoExit
} else {
    #Error exit
    Write-Host "`n`n`tPlease select valid option`n"
    Start-Sleep(5)
}