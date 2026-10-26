# Canvia · Automatización Web con Playwright + TypeScript + Cucumber

Proyecto base del curso de QA Automation (parte 2): pruebas end-to-end con **Playwright** y **TypeScript**,
escenarios en **Gherkin (español)** con **Cucumber** y patrón **Page Object**.
Aplicación bajo prueba: [SauceDemo](https://www.saucedemo.com).

## Empieza aquí

| Si... | Sigue |
|---|---|
| Vas a configurar tu PC | [Instalación en Windows, paso a paso](docs/01-instalacion-windows-paso-a-paso.md) |
| No pudiste instalar Node o Playwright | Doble clic en **`iniciar-entorno.bat`** → [Entorno listo en Docker](docs/02-entorno-docker-alumnos.md) |
| Es tu primera vez con Git | [Git y GitHub](docs/04-git-y-github.md) |
| Eres el instructor | [Windows en Docker para la demo](docs/03-windows-en-docker-instructor.md) |

Toda la documentación: [docs/](docs/README.md).

## Ejecutar

```powershell
npm install                       # dependencias (una vez)
npx playwright install chromium   # navegador (una vez)
npm test                          # todos los escenarios
npm run test:smoke                # solo @smoke
npm run test:headed               # viendo el navegador
npm run typecheck                 # revisión de tipos
```

Resultado esperado: `3 scenarios (3 passed)`. Reporte: `reports/cucumber-report.html`.
Otra URL: `$env:BASE_URL="https://mi-ambiente"; npm test`.

## Estructura

```text
├── features/                       escenarios .feature en español
├── src/
│   ├── pages/                      Page Objects (selectores y acciones de cada pantalla)
│   ├── steps/                      código de cada paso Gherkin
│   └── support/                    hooks (navegador por escenario) y World compartido
├── cucumber.js                     configuración de Cucumber
├── docker-compose.yml + iniciar-entorno.*  entorno listo para alumnos
├── docker/windows/                 Windows 11 en Docker para la demo
└── docs/                           guías y PDF del curso
```

## Versiones

| Herramienta | Versión |
|---|---|
| Node.js | 22 o 24 (LTS) |
| Playwright | 1.64.1 |
| @cucumber/cucumber | 13.3.0 |
| TypeScript | 7.0.2 |
| tsx | 4.23 |

## Cómo se trabaja

1. `develop` es la rama de trabajo; `main` guarda las versiones estables.
2. Cada ejercicio va en su rama `feature/<ejercicio>-<tu-nombre>`.
3. Se entrega con un Pull Request a `develop`; la CI corre `typecheck` y `npm test` y debe quedar en verde.

Detalle en [Git y GitHub](docs/04-git-y-github.md#6-el-flujo-de-cada-ejercicio).
