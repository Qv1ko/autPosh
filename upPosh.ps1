Write-Host "Updating..."
winget upgrade Microsoft.WindowsTerminal -s winget -h --accept-package-agreements --accept-source-agreements cf | out-null
winget upgrade PowerShell -s winget -h --accept-package-agreements --accept-source-agreements cf | out-null
winget upgrade JanDeDobbeleer.OhMyPosh -s winget -h --accept-package-agreements --accept-source-agreements cf | out-null
Clear-Host
wt -w 0 nt -p "pwsh" -NoExit -c {(Invoke-WebRequest "https://raw.githubusercontent.com/kiedtl/winfetch/master/winfetch.ps1" -UseBasicParsing).Content.Remove(0,1) | Invoke-Expression}
wt -w 0 nt --title "autPosh" -p "PowerShell" -NoExit -command {& (Invoke-WebRequest "https://raw.githubusercontent.com/kiedtl/winfetch/master/winfetch.ps1" -UseBasicParsing).Content.Remove(0,1) | Invoke-Expression}
Start-Process wt.exe -ArgumentList "PowerShell", "-NoExit", "-Command", "(Invoke-WebRequest `"https://raw.githubusercontent.com/kiedtl/winfetch/master/winfetch.ps1`" -UseBasicParsing).Content.Remove(0,1) | Invoke-Expression"