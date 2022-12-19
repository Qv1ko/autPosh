# Guia de instalación y configuración de Windows Terminal:

1. Instalar **Windows Terminal** y **PowerShell** desde Microsoft Store
2. Establecer **PowerShell** como **predeterminado** en Windows Terminal:
    1. Abrir Windows Terminal
    2. Presionar las teclas `Ctrl`+`,` para abrir la configuración de Windows Terminal
    3. En la sección "Inicio", buscar la opción "Perfil Predeterminado" y establecer "PowerShell" como valor
3. **Instalar** una **fuente** para la PowerShell:
    1. Acceder a la página web de [NerdFonts](https://www.nerdfonts.com/font-downloads) y elegir una fuente
    2. Descargar la fuente pulsando en el boton de `Download`
    3. Descomprimir el archivo descargado
    4. Abrir el archivo de la fuente
    5. Seleccionar todos los archivos excluyendo "LICENSE.txt" y "readme.md"
    6. Hacer clic derecho y seleccionar la opcion de "Instalar" para instalar la fuente en nuestro sistema
4. **Establecer** la **fuente** de PowerShell en Windows Terminal:
    1. Abrir Windows Terminal
    2. Presionar las teclas `Ctrl`+`,` para abrir la configuración de Windows Terminal
    3. Acceder ha "Apariencia", dentro del apartado "Configuracion adicional" de "PowerShell" en la sección "Perfiles"
    4. Establecer como valor en la opción "Tipo de fuente" la fuente instalada
5. Instalamos **OhMyPosh**:
    1. Abrir Windows Terminal
    2. Escribir el comando `Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))` para instalar OhMyPosh en el sistema
    3.Recargar perfil de PowerShell escribiendo en Windows Terminal el comando `. $PROFILE`
6. Escoger tema para el **prompt** accediendo a la página web de [OhMyPosh](https://ohmyposh.dev/docs/themes)

7. Crear y editar **archivo** de **configuración** de PowerShell:
    1. Abrir Windows Terminal
    2. Escribir `New-Item -Path $PROFILE -Type File -Force` para crear el archivo de configuración de PowerShell en la ubicación correcta
    3. Escribir `notepad $PROFILE` para abrir el archivo con notepad
    4. Añadir al archivo el siguiente texto:
        ```txt
        oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\NombreTema.omp.json" | Invoke-Expression
        Import-Module -Name Terminal-Icons
        ```
    5. Reemplazar "NombreTema" por el nombre del tema escogido en el paso anterior
8. Instalar el **módulo** de **iconos** de archivos escribiendo en Windows Terminal `Install-Module -Name Terminal-Icons -Repository PSGallery`
9. **Recargar** perfil de PowerShell escribiendo en Windows Terminal el comando `. $PROFILE`

## Créditos:

* [NerdFonts](https://www.nerdfonts.com) (Distribuidores de las fuentes)
* [OhMyPosh](https://ohmyposh.dev) (Creador del prompt)
* [Terminal-Icons](https://github.com/devblackops/Terminal-Icons) (Módulo de iconos de archivos y carpetas)

### Link al [Pastebin](https://pastebin.com/Cddz1498)
