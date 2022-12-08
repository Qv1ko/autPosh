Start-Process "https://ohmyposh.dev/docs/themes"
$PoshTheme=Read-Host "Write your favourite theme"
Write-Output "oh-my-posh init pwsh --config `"`$env:POSH_THEMES_PATH\$PoshTheme`.omp.json`" | Invoke-Expression`nImport-Module -Name Terminal-Icons" | Out-File $env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
wt -w 0 nt pwsh -NoExit