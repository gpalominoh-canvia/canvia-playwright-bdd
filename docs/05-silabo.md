# Sílabo · Pruebas Web con Playwright + Screenplay + Cucumber

> Versión para imprimir: [PDF con formato Canvia](pdf/silabo-playwright-screenplay.pdf).

> Parte 2 del curso de QA Automation de Canvia. 100 % práctico: cada sesión termina con código tuyo en verde y un Pull Request.

| | |
|---|---|
| **Horario** | martes 27 a viernes 30 de octubre de 2026 · 17:30 a 18:45 (4 sesiones de 75 min) |
| **Requisito** | haber completado la instalación (`npm test` en verde) — [paso a paso](01-instalacion-windows-paso-a-paso.md) |
| **Web de práctica** | [SauceDemo](https://www.saucedemo.com) (tienda en línea) |
| **Web del examen** | Portal Canvia Market (lo levanta el instructor; también corre en tu PC y en la CI) |
| **Entregas** | Pull Request a `develop` por cada sesión, con la CI en verde ([cómo](04-git-y-github.md#6-el-flujo-de-cada-ejercicio)) |

## Al terminar la semana sabrás

1. Automatizar flujos web reales con Playwright: selectores robustos, esperas automáticas y aserciones.
2. Escribir los escenarios en Gherkin en español, de forma que negocio los entienda.
3. Aplicar el patrón **Screenplay**: actores con habilidades que ejecutan tareas y responden preguntas.
4. Obtener evidencia útil: capturas, trazas y reportes cuando algo falla.
5. Correr todo en un **pipeline de CI** que publica el reporte en cada Pull Request.

## Plan de sesiones

### Sesión 1 · martes 27 — Playwright + Cucumber desde el proyecto base

| Tiempo | Qué hacemos |
|---|---|
| 10 min | Entorno verificado: `npm test` en verde en todas las PC |
| 20 min | Navegador, contexto y página; selectores por `data-test`; esperas y aserciones web-first |
| 15 min | Cómo se conecta Cucumber: World, hooks y steps |
| 30 min | **Ejercicios 1 y 2** |

- **Ejercicio 1** · Cerrar sesión y comprobar que no se puede volver atrás.
- **Ejercicio 2** · Un carrito que cuenta bien (agregar, quitar y verificar el contador).
- **Entrega:** PR `feature/s1-<tu-nombre>`.

### Sesión 2 · miércoles 28 — De Page Object a Screenplay

| Tiempo | Qué hacemos |
|---|---|
| 10 min | Revisión de los PR de ayer |
| 10 min | Por qué Screenplay: el escenario habla de personas y objetivos, no de botones |
| 25 min | En vivo: `Actor`, `Ability`, `Interaction`, `Task` y `Question`; el login reescrito en Screenplay |
| 30 min | **Ejercicio 3** · ¿El ordenamiento ordena? con una `Question` reutilizable |

- **Entrega:** PR `feature/s2-<tu-nombre>`.

### Sesión 3 · jueves 29 — Screenplay + Cucumber a escala

| Tiempo | Qué hacemos |
|---|---|
| 20 min | El actor vive en el World: los steps solo delegan; tareas compuestas y tablas de datos |
| 15 min | Evidencia: captura y traza de Playwright solo cuando falla; reporte HTML de Cucumber |
| 40 min | **Ejercicios 4 y 5** |

- **Ejercicio 4** · Una compra completa que cuadra (tarea `CompletarCompra` + preguntas sobre el total).
- **Ejercicio 5** · Caza de bugs con el usuario `problem_user`.
- **Entrega:** PR `feature/s3-<tu-nombre>` con un `BUGS.md`.

### Sesión 4 · viernes 30 — Reportes, pipeline y examen final

| Tiempo | Qué hacemos |
|---|---|
| 25 min | GitHub Actions: caché de npm, Chromium en la CI, reporte y capturas como artefactos, resumen en el PR y publicación en GitHub Pages |
| 45 min | **Examen final** sobre la web del Portal Canvia Market |
| 5 min | Cierre |

## Examen final (45 min)

Automatiza contra la web del Portal Canvia Market, en tu rama `feature/examen-<tu-nombre>`:

| Criterio | Peso |
|---|---|
| Escenarios en Gherkin claros, en español y declarativos | 20 % |
| Screenplay bien aplicado (tareas, interacciones y preguntas separadas) | 30 % |
| Flujos funcionando: login, búsqueda, carrito y compra | 20 % |
| Pipeline en verde con el reporte publicado | 20 % |
| Bugs encontrados y documentados | 10 % |

Aprobación: 70 %. El enunciado completo se publica en el portal al iniciar el examen.

## Cómo se evalúa cada sesión

| | Cumple | Falta |
|---|---|---|
| Ejecuta | `npm test` y `npm run typecheck` en verde en tu PC y en la CI | Falla o no compila |
| Se entiende | Gherkin en español de negocio, sin selectores en el `.feature` | Pasos técnicos en el escenario |
| Es robusto | Selectores `data-test` o por rol; sin `waitForTimeout` | Esperas fijas o XPath frágiles |
| Es Screenplay | Los steps solo llaman al actor | Lógica o selectores en los steps |

---

[Índice](README.md) · Material de clase: [presentaciones en PDF](pdf/)
