#Administrator PowerShell
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

#Gloval variables
Write-Host "Options: `n  1) Installing `n  2) Updating `n  3) Exit"
$options=Read-Host "Select option"
$oldpath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path

#Function
switch ($options) {
    1 {
        $newpath = "$oldpath;$env:USERPROFILE\AppData\Local\Microsoft\WindowsApps\"
        Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newpath

        if (Test-Path $env:USERPROFILE\AppData\Local\Microsoft\WindowsApps\winget.exe){
            'Winget already installed'
        }  
        else{
            Write-Host "Install Winget"
            Start-Process "ms-appinstaller:?source=https://aka.ms/getwinget"
            $wiid = (Get-Process AppInstaller).Id
	        Wait-Process -Id $wiid
            . $PROFILE
        }

        if (Test-Path $env:USERPROFILE\AppData\Local\Microsoft\WindowsApps\wt.exe){
            'Windows Terminal already installed'
        }  
        else{
            Write-Host "Install Windows Terminal"
            winget install --id=Microsoft.WindowsTerminal -e
            . $PROFILE
        }

        if (Test-Path $env:USERPROFILE\AppData\Local\Microsoft\WindowsApps\pwsh.exe){
            'PowerShell already installed'
        }  
        else{
            Write-Host "Install PowerShell"
            winget install --id Microsoft.Powershell --source winget
            . $PROFILE
        }
        
        Write-Host "Install Firacode font"
        Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        choco install firacode -y

        Write-Host "Terminal configuration"
        $terminalpath = Get-ChildItem -Path "$env:USERPROFILE\AppData\Local\Packages\" -Name "Microsoft.WindowsTerminal_*" -Directory
        $jsonpath="$env:USERPROFILE\AppData\Local\Packages\$terminalpath\LocalState\settings.json"
        Write-Output "`"defaultProfile`": `"{5fb123f1-af88-5b5c-8953-d14a8def1978}`",`n`"profiles`":`n`t{`n`t`t`"defaults`":`n`t`t{`n`t`t`t`"fontFace`":`"Fira Code`"`n`t`t},`n`t`t`"list`":`n`t`t[]`n`t}"  | Out-File $jsonpath
        
        Write-Host "Install and configure OhMyPosh"
        winget install JanDeDobbeleer.OhMyPosh -s winget
        New-Item -Path $PROFILE -Type File -Force
        Start-Process "https://ohmyposh.dev/docs/themes"
        $theme=Read-Host "Write your favourite theme"
        Write-Output "oh-my-posh init pwsh --config `"`$env:POSH_THEMES_PATH\$theme`.omp.json`" | Invoke-Expression`nImport-Module -Name Terminal-Icons" | Out-File $PROFILE
        . $PROFILE
        
        Write-Host "Install icons module"
        Install-PackageProvider NuGet -Force;
        Set-PSRepository PSGallery -InstallationPolicy Trusted
        Install-Module -Name Terminal-Icons -Repository PSGallery
        . $PROFILE
        
        Write-Host "`nFinished`n"
        Start-Sleep(5)
    }
    2 {
        winget upgrade Microsoft.WindowsTerminal -s winget -h --accept-package-agreements --accept-source-agreements
        winget upgrade Microsoft.Powershell -s winget -h --accept-package-agreements --accept-source-agreements
        winget upgrade JanDeDobbeleer.OhMyPosh -s winget -h --accept-package-agreements --accept-source-agreements
        Start-Sleep(2)
        Clear-Host; (Invoke-WebRequest "https://raw.githubusercontent.com/kiedtl/winfetch/master/winfetch.ps1" -UseBasicParsing).Content.Remove(0,1) | Invoke-Expression
        Start-Sleep(5)
    }
    3 {
        Write-Host "`nExit...`n"
        Start-Sleep(3)
    }
    Default {
        Write-Host "`n!Select valid option`n"
    }
}