# Guia de instalación y configuración de Windows Terminal:

1.  Instalamos desde Microsoft Store:
    * Terminal
    * PowerShell

2.  Establecemos PowerShell como predeterminado en Windows Terminal:
    1. Ctrl+,
    2. Inicio\Perfil Predeterminado -> PowerShell

3.  Instalamos la fuente para la PowerShell:
    1. Accedemos a la página web de [NerdFonts](www.nerdfonts.com/font-downloads), escogemos una fuente y la descargamos
    2. Descomprimimos el archivo descargado e instalamos la fuente

4. Configuramos el tipo de fuente de Windows Terminal:
    1. Ctrl+,
    2. PowerShell>Apariencia\Tipo de fuente -> Fuente instalada

5. Instalamos OhMyPosh escribiendo en la terminal el siguiente comando:
    `winget install JanDeDobbeleer.OhMyPosh -s winget`

6. Escogemos un tema para el prompt:
    1. Accedemos a la página web de [OhMyPosh](ohmyposh.dev/docs/themes) y escogemos el tema que más nos guste

7. Creamos el archivo de configuracion de PowerShell escribiendo el siguiente comando en la terminal:
    * `New-Item -Path $PROFILE -Type File -Force`
    * `notepad $PROFILE`
    
8. Ponemos la configuración de PowerShell en el bloc de notas abierto:
    *Cambiamos la cadena de texto "NombreTema" por el nombre del tema escogido*
    ```txt
    oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\NombreTema.omp.json" | Invoke-Expression
    Import-Module -Name Terminal-Icons
    ```

9. Recargamos la configuracion escribiendo en la terminal el siguiente comando:
    `. $PROFILE`

10. Instalamos el módulo de visión de archivos escribiendo en la terminal el siguiente comando:
    `Install-Module -Name Terminal-Icons -Repository PSGallery`


# Créditos:
* NerdFonts (Distribuidores de las fuentes) -> www.nerdfonts.com
* OhMyPosh (Creador de prompt) -> ohmyposh.dev
* Terminal-Icons (Módulo de iconos de archivos y carpetas) -> github.com/devblackops/Terminal-Icons

--------------------------------------------------------------------------------------------------------

# Windows Terminal installation and configuration guide:

1. Install from Microsoft Store:

    - Terminal
    - PowerShell

2.  Set PowerShell as default in Windows Terminal:

    1. Ctrl+,
    2. Startup\Default Profile -> PowerShell

3.  Install the font for the PowerShell:

    1. Go to the NerdFonts website (www.nerdfonts.com/font-downloads), choose a font and download it.
    2. Unzip the downloaded file and install the font.

4. Set the Windows Terminal font type:

    1. Ctrl+,
    2. PowerShell>Appearance\Font face -> Installed Font

5. Install OhMyPosh by typing the following command in the terminal:

    winget install JanDeDobbeleer.OhMyPosh -s winget

6. Choose a theme for the prompt:

    1. Go to the OhMyPosh website (ohmyposh.dev/docs/themes) and choose the theme you like the most.

7. Create the PowerShell configuration file by typing the following command in the terminal:

    New-Item -Path $PROFILE -Type File -Force
    notepad $PROFILE
    
8. Put the PowerShell configuration in the open notepad:
    *Change the string "ThemeName" to the name of the chosen theme.

    oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\ThemeName.omp.json" | Invoke-Expression
    Import-Module -Name Terminal-Icons

9. Reload the configuration by typing the following command in the terminal:

    . $PROFILE

10. Install the file viewer module by typing the following command in the terminal:

    Install-Module -Name Terminal-Icons -Repository PSGallery


# Credits:

    NerdFonts (Font Distributors) -> www.nerdfonts.com
    OhMyPosh (Prompt creator) -> ohmyposh.dev
    Terminal-Icons (File and folder icon module) -> github.com/devblackops/Terminal-Icons
    
--------------------------------------------------------------------------------------------------------
    
    Pastebin-Link -> https://pastebin.com/Cddz1498
