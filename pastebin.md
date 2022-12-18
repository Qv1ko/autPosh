# Guia de instalación y configuración de Windows Terminal:

1.  Instalamos desde Microsoft Store:
    * Windows Terminal
    * PowerShell

2.  Establecemos PowerShell como predeterminado en Windows Terminal:
    1. `Ctrl+,`
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

    **Cambiamos la cadena de texto "NombreTema" por el nombre del tema escogido**

    ```txt
    oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\NombreTema.omp.json" | Invoke-Expression
    Import-Module -Name Terminal-Icons
    ```

9. Recargamos la configuracion escribiendo en la terminal el siguiente comando:

    `. $PROFILE`

10. Instalamos el módulo de visión de archivos escribiendo en la terminal el siguiente comando:

    `Install-Module -Name Terminal-Icons -Repository PSGallery`


## Créditos:
* [NerdFonts](www.nerdfonts.com) (Distribuidores de las fuentes)
* [OhMyPosh](ohmyposh.dev) (Creador del prompt)
* [Terminal-Icons](github.com/devblackops/Terminal-Icons) (Módulo de iconos de archivos y carpetas)

## Link del [Pastebin](https://pastebin.com/Cddz1498)