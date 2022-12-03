#Administrator PowerShell
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

#path deleting
$oldpath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
$newpath = "$oldpath;$env:USERPROFILE\AppData\Local\Microsoft\WindowsApps\"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newpath

#windows terminal and powershell uninstall condition
if (Test-Path $env:USERPROFILE\AppData\Local\Microsoft\WindowsApps\wt.exe) {
    winget uninstall --id=Microsoft.WindowsTerminal -e --accept-package-agreements --accept-source-agreements
}
if (Test-Path $env:USERPROFILE\AppData\Local\Microsoft\WindowsApps\pwsh.exe) {
    winget uninstall --id Microsoft.Powershell --source winget --accept-package-agreements --accept-source-agreements
}

#terminal font installing
Write-Host "Uninstall Mononoki font"
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install nerd-fonts-mononoki -y

#terminal configuration
Write-Host "Terminal configuration"
Copy-Item -Path $PSCommandPath\..\settings.json -Destination $env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\ -Force

#ohmyposh install and configuration
Write-Host "Uninstall and configure OhMyPosh"
winget install JanDeDobbeleer.OhMyPosh -s winget
New-Item -Path $env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 -Type File -Force
Write-Output "oh-my-posh init pwsh --config `"`$env:POSH_THEMES_PATH\$theme`.omp.json`" | Invoke-Expression`nImport-Module -Name Terminal-Icons" | Out-File $env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1

#module icons installing
Write-Host "Uninstall icons module"
Install-PackageProvider NuGet -Force;
Set-PSRepository PSGallery -InstallationPolicy Trusted
Install-Module -Name Terminal-Icons -Repository PSGallery