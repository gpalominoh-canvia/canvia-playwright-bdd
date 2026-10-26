# Instalación en Windows, paso a paso

Guion para configurar una PC Windows desde cero hasta ver los escenarios en verde.
El instructor lo sigue en vivo sobre un Windows limpio (ver [Windows en Docker](03-windows-en-docker-instructor.md))
y los alumnos replican cada paso en su PC.

Detalle completo, macOS/Linux y solución de errores: [manual de instalación (PDF)](pdf/manual-instalacion-playwright-cucumber.pdf).

| Paso | Qué instalamos | Comprobación |
|---|---|---|
| 0 | Terminal y winget | `winget --version` |
| 1 | Node.js LTS (22 o 24) | `node -v` |
| 2 | Git | `git --version` |
| 3 | VS Code + extensiones | `code --version` |
| 4 | Proyecto, dependencias y Chromium | `npm test` en verde |

> ¿Ya hiciste la parte 1 (REST Assured)? Ya tienes Git y VS Code: solo te faltan Node.js (Paso 1),
> las dos extensiones del Paso 3 y el Paso 4. Esta parte **no** necesita Java.

---

## Paso 0 · Abrir la terminal

1. Clic derecho en el botón de Inicio → **Terminal**. Se abre PowerShell.
2. Comprueba que tienes `winget`:

```powershell
winget --version
```

Si no se reconoce, abre **Microsoft Store**, busca **Instalador de aplicación** y actualízalo.
La primera vez que uses `winget` te pedirá aceptar los términos: responde `Y`.

> Regla de oro: **después de cada instalación, cierra la terminal y abre una nueva**.

---

## Paso 1 · Node.js LTS

Cucumber 13 exige **Node 22 o 24**. Instala la versión LTS:

```powershell
winget install OpenJS.NodeJS.LTS
```

Alternativa: el instalador `.msi` de <https://nodejs.org> (botón **LTS**), con las opciones por defecto.

Cierra y abre la terminal. Comprueba:

```powershell
node -v
npm -v
```

```text
v24.x.x
11.x.x
```

**Si `npm` falla con "la ejecución de scripts está deshabilitada"** (PowerShell bloquea `npm.ps1`):

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

**Si `node -v` muestra una versión menor a 22**, desinstala la vieja desde *Configuración → Aplicaciones*
y repite el paso.

---

## Paso 2 · Git

```powershell
winget install --id Git.Git -e
```

Cierra y abre la terminal:

```powershell
git --version
```

La configuración de tu nombre, correo y cuenta de GitHub está en la [guía de Git y GitHub](04-git-y-github.md#3-configurar-git-una-sola-vez-por-pc).

---

## Paso 3 · VS Code y extensiones

```powershell
winget install Microsoft.VisualStudioCode
```

Cierra y abre la terminal, e instala las extensiones del curso:

```powershell
code --install-extension ms-playwright.playwright
code --install-extension CucumberOpen.cucumber-official
```

| Extensión | Para qué |
|---|---|
| Playwright Test for VS Code | Generar selectores y grabar acciones (*Pick locator*, *Record new*) |
| Cucumber (Gherkin) Full Support | Colores en los `.feature` y salto del step al código TypeScript |

---

## Paso 4 · Proyecto, dependencias y navegador

```powershell
mkdir C:\cursos
cd C:\cursos
git clone <url-de-este-repositorio>
cd canvia-playwright-bdd
code .
```

En la terminal de VS Code (`Ctrl+ñ`):

```powershell
npm install
npx playwright install chromium
npm test
```

| Comando | Qué hace |
|---|---|
| `npm install` | Descarga las librerías del `package.json` a `node_modules/` |
| `npx playwright install chromium` | Descarga el navegador Chromium que usa Playwright |
| `npm test` | Corre los escenarios de `features/` |

Esperado:

```text
3 scenarios (3 passed)
```

El reporte HTML queda en `reports/cucumber-report.html`.

Otras formas de ejecutar:

```powershell
npm run test:smoke      # solo escenarios @smoke
npm run test:headed     # viendo el navegador
npm run typecheck       # revisa tipos de TypeScript
```

---

## Si algo falla

| Síntoma | Causa | Solución |
|---|---|---|
| `'node' no se reconoce...` | Terminal vieja o instalación incompleta | Abre otra terminal; si sigue, reinstala (Paso 1) |
| `npm.ps1 cannot be loaded` | Política de ejecución de PowerShell | `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` |
| `ERR_UNSUPPORTED_TYPESCRIPT_SYNTAX` | Se corrió `npx cucumber-js` directo | Usa `npm test` (carga `tsx`) |
| `Executable doesn't exist at ...ms-playwright...` | Falta el navegador | `npx playwright install chromium` |
| `npm ERR! code ETIMEDOUT` | Proxy corporativo | `npm config set proxy http://host:puerto` (pide los datos a Mesa de Ayuda) |
| `Unsupported engine` de `@cucumber/cucumber` | Node menor a 22 | Paso 1 |

¿Nada de esto funciona y tienes Docker? Usa el [entorno listo en Docker](02-entorno-docker-alumnos.md).

---

[Índice de documentación](README.md) · Siguiente: [Entorno listo en Docker](02-entorno-docker-alumnos.md)
