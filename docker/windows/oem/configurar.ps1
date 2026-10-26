# Instala lo que pide el manual: Node.js LTS, Git y VS Code.
# Se ejecuta como administrador durante la instalación de Windows. Registro en C:\OEM\configurar.log
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$descargas = 'C:\OEM\descargas'
New-Item -ItemType Directory -Force $descargas | Out-Null

function Descargar($url, $destino) {
    Write-Host "Descargando $url"
    Invoke-WebRequest -Uri $url -OutFile $destino -UseBasicParsing
}

# 1. Node.js LTS (la versión LTS más reciente; Cucumber 13 exige Node 22 o 24+)
$lts = Invoke-RestMethod 'https://nodejs.org/dist/index.json' | Where-Object { $_.lts } | Select-Object -First 1
Descargar "https://nodejs.org/dist/$($lts.version)/node-$($lts.version)-x64.msi" "$descargas\node.msi"
Start-Process msiexec.exe -Wait -ArgumentList "/i `"$descargas\node.msi`" /qn"

# 2. Git para Windows (última versión estable)
$release = Invoke-RestMethod 'https://api.github.com/repos/git-for-windows/git/releases/latest'
$gitUrl = ($release.assets | Where-Object { $_.name -match '^Git-.*-64-bit\.exe$' } | Select-Object -First 1).browser_download_url
Descargar $gitUrl "$descargas\git.exe"
Start-Process "$descargas\git.exe" -Wait -ArgumentList '/VERYSILENT /NORESTART /NOCANCEL /SP- /SUPPRESSMSGBOXES'

# 3. VS Code para todos los usuarios, con "Abrir con Code" y en el Path
Descargar 'https://update.code.visualstudio.com/latest/win32-x64/stable' "$descargas\vscode.exe"
Start-Process "$descargas\vscode.exe" -Wait -ArgumentList '/VERYSILENT /NORESTART /MERGETASKS=!runcode,addcontextmenufiles,addcontextmenufolders,addtopath'

# 4. Extensiones, proyecto y navegador son por usuario: se hacen al primer inicio de sesión.
$inicio = 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\canvia-primer-inicio.cmd'
Set-Content -Path $inicio -Encoding ASCII -Value 'powershell -NoProfile -ExecutionPolicy Bypass -File "C:\OEM\primer-inicio.ps1"'

Remove-Item $descargas -Recurse -Force
Write-Host 'Configuracion terminada.'
