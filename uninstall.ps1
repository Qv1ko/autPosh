#Elevation of script privileges
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}
#Icons module uninstallation
Uninstall-Module -Name Terminal-Icons
Uninstall-Module -Name Terminal-Icons -Repository PSGallery
#OhMyPosh uninstallation
winget uninstall JanDeDobbeleer.OhMyPosh -s winget
Remove-Item -Path "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -Force
#Font uninstallation
choco uninstall nerd-fonts-mononoki -y
#Powershell uninstall condition
if (Test-Path "$env:USERPROFILE\AppData\Local\Microsoft\WindowsApps\pwsh.exe") {
    winget uninstall --id Microsoft.Powershell --source winget --accept-package-agreements --accept-source-agreements
}
#Deleting terminal configuration
Remove-Item -Path "$env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Force
#Windows terminal uninstall condition
if (Test-Path "$env:USERPROFILE\AppData\Local\Microsoft\WindowsApps\wt.exe") {
    winget uninstall --id=Microsoft.WindowsTerminal -e --accept-package-agreements --accept-source-agreements
}