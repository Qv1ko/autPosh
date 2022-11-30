#Administrator PowerShell
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

#path adding
$oldpath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
$newpath = "$oldpath;$env:USERPROFILE\AppData\Local\Microsoft\WindowsApps\"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newpath

#winget install condition
if (!(Test-Path $env:USERPROFILE\AppData\Local\Microsoft\WindowsApps\winget.exe)) {
    Write-Host "Install Winget"
    Start-Process "ms-appinstaller:?source=https://aka.ms/getwinget"
    $wiid = (Get-Process AppInstaller).Id
    Wait-Process -Id $wiid
    . $PROFILE
}

#windows terminal install condition
if (!(Test-Path $env:USERPROFILE\AppData\Local\Microsoft\WindowsApps\wt.exe)) {
    Write-Host "Install Windows Terminal"
    winget install --id=Microsoft.WindowsTerminal -e --accept-package-agreements --accept-source-agreements
    . $PROFILE
}

#powershell install condition
if (!(Test-Path $env:USERPROFILE\AppData\Local\Microsoft\WindowsApps\pwsh.exe)) {
    Write-Host "Install PowerShell"
    winget install --id Microsoft.Powershell --source winget --accept-package-agreements --accept-source-agreements
    . $PROFILE
}

#terminal font installing
Write-Host "Install !Firacode! font"
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install firacode -y

    #terminal configuration
    Write-Host "Terminal configuration"
    $wd = Get-Location
    if(!(Test-Path "$env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_*")) {
        New-Item "$env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState" -ItemType Directory
    }
    $terminalpath = Get-ChildItem -Path "$env:USERPROFILE\AppData\Local\Packages\" -Name "Microsoft.WindowsTerminal_*" -Directory
    Copy-Item -Path $wd\settings.json -Destination $env:USERPROFILE\AppData\Local\Packages\$terminalpath\LocalState\ -PassThru

#ohmyposh install and configuration
Write-Host "Install and configure OhMyPosh"
winget install JanDeDobbeleer.OhMyPosh -s winget
New-Item -Path $env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 -Type File -Force
Start-Process "https://ohmyposh.dev/docs/themes"
$theme=Read-Host "Write your favourite theme"
Write-Output "oh-my-posh init pwsh --config `"`$env:POSH_THEMES_PATH\$theme`.omp.json`" | Invoke-Expression`nImport-Module -Name Terminal-Icons" | Out-File $env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1

#module icons installing
Write-Host "Install icons module"
Install-PackageProvider NuGet -Force;
Set-PSRepository PSGallery -InstallationPolicy Trusted
Install-Module -Name Terminal-Icons -Repository PSGallery

#exit
Read-Host "Pulse Enter para salir"
Exit