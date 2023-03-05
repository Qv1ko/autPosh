#Elevation of script privileges
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}
#Icons module uninstallation
Uninstall-Module -Name Terminal-Icons
#OhMyPosh uninstallation
winget uninstall JanDeDobbeleer.OhMyPosh -s winget
Remove-Item -Path "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -Force
#Font uninstallation
choco uninstall nerd-fonts-mononoki -y
#Powershell uninstall condition
winget uninstall --id Microsoft.Powershell --source winget
#Windows terminal uninstall condition
winget uninstall --id=Microsoft.WindowsTerminal -e