# Corre en cada inicio de sesión, pero solo trabaja la primera vez por usuario.
$marca = "$env:USERPROFILE\.canvia-configurado"
if (Test-Path $marca) { exit 0 }

$code = 'C:\Program Files\Microsoft VS Code\bin\code.cmd'
foreach ($ext in 'ms-playwright.playwright', 'CucumberOpen.cucumber-official') {
    & $code --install-extension $ext --force
}

# Copia el repositorio (carpeta compartida por Docker) al escritorio e instala dependencias y Chromium.
$origen = '\host.lan\Data'
$destino = "$env:USERPROFILE\Desktop\canvia-playwright-bdd"
if (Test-Path $origen) {
    robocopy $origen $destino /E /XD node_modules reports /NFL /NDL /NJH /NJS | Out-Null
    Push-Location $destino
    npm ci
    npx playwright install chromium
    Pop-Location
}

New-Item -ItemType File $marca | Out-Null
