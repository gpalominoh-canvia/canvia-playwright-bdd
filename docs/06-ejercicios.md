# Ejercicios del curso

> Enunciados de los ejercicios 1 a 5 sobre [SauceDemo](https://www.saucedemo.com). Los tiempos y las entregas
> son los del [sílabo](05-silabo.md). Aquí no hay soluciones: hay lo que se pide, cómo se revisa y pistas.

| # | Ejercicio | Sesión | Patrón | Entrega |
|---|---|---|---|---|
| 1 | [Cerrar sesión y no poder volver atrás](#ejercicio-1--cerrar-sesión-y-no-poder-volver-atrás) | 1 · martes 27 | Page Object | `feature/s1-<tu-nombre>` |
| 2 | [Un carrito que cuenta bien](#ejercicio-2--un-carrito-que-cuenta-bien) | 1 · martes 27 | Page Object | `feature/s1-<tu-nombre>` |
| 3 | [¿El ordenamiento ordena?](#ejercicio-3--el-ordenamiento-ordena) | 2 · miércoles 28 | Screenplay | `feature/s2-<tu-nombre>` |
| 4 | [Una compra completa que cuadra](#ejercicio-4--una-compra-completa-que-cuadra) | 3 · jueves 29 | Screenplay | `feature/s3-<tu-nombre>` |
| 5 | [Caza de bugs con `problem_user`](#ejercicio-5--caza-de-bugs-con-problem_user) | 3 · jueves 29 | Screenplay | `feature/s3-<tu-nombre>` + `BUGS.md` |

**Reglas para todos** (son las de la [rúbrica del sílabo](05-silabo.md#cómo-se-evalúa-cada-sesión)):

- `npm run typecheck` y `npm test` en verde en tu PC y en la CI antes de abrir el Pull Request.
- Gherkin en español de negocio: ni selectores, ni URLs, ni "hago clic" en el `.feature`.
- Selectores `data-test` o por rol (`getByRole`). Cero `waitForTimeout`: si necesitas esperar, falta una aserción.
- Cada escenario lleva la etiqueta de su ejercicio (`@ejercicio1`...) para poder correrlo solo:
  `npm test -- --tags @ejercicio1`.
- Todos los usuarios de SauceDemo usan la clave `secret_sauce`.

---

## Ejercicio 1 · Cerrar sesión y no poder volver atrás

**Sesión 1** · Page Object · dificultad 1 de 5

### Objetivo

Automatizar el cierre de sesión y comprobar el control de acceso: después de salir, ni el botón "atrás" del
navegador ni la URL directa deben mostrar el catálogo.

### Criterios de aceptación

1. Tras iniciar sesión, abrir el menú lateral y elegir *Logout* lleva de vuelta a la pantalla de login.
2. Después de cerrar sesión, volver atrás con el navegador **no** muestra productos: aparece un mensaje de error.
3. Sin sesión, abrir directamente `/inventory.html` tampoco muestra productos: aparece el mismo error.
4. Existe un Page Object nuevo, `MenuPage.ts`; los steps no tienen selectores.
5. Se reutilizan los pasos de login y de mensaje de error que ya existen: no se duplican.

### Punto de partida

```gherkin
# language: es
@ejercicio1
Característica: Cierre de sesión y control de acceso

  Antecedentes:
    Dado que estoy en la página de login

  Escenario: Cerrar sesión
    Cuando ingreso con el usuario "standard_user" y la clave "secret_sauce"
    Y cierro sesión desde el menú
    Entonces vuelvo a la página de login

  Escenario: Después de cerrar sesión no se puede volver atrás
    Cuando ingreso con el usuario "standard_user" y la clave "secret_sauce"
    Y cierro sesión desde el menú
    Y vuelvo atrás con el navegador
    Entonces veo el mensaje de error "You can only access"
    Y no veo ningún producto

  Escenario: Sin sesión no se ve el catálogo
    Cuando intento abrir el catálogo sin iniciar sesión
    Entonces veo el mensaje de error "You can only access"
    Y no veo ningún producto
```

### Pistas

- Botón del menú: `page.getByRole('button', { name: 'Open Menu' })` (o `#react-burger-menu-btn`).
  Opción de salir: `[data-test="logout-sidebar-link"]`.
- Volver atrás: `page.goBack()`. Ir a una ruta: `page.goto('/inventory.html')` (usa la `baseURL` del contexto).
- `await expect(this.page).toHaveURL('https://www.saucedemo.com/')`.
- "No veo ningún producto" se verifica con `toHaveCount(0)` sobre `[data-test="inventory-item"]`.

---

## Ejercicio 2 · Un carrito que cuenta bien

**Sesión 1** · Page Object · dificultad 2 de 5

### Objetivo

Agregar varios productos desde una lista de Gherkin, quitar alguno y verificar que el contador y el contenido
del carrito siempre dicen la verdad.

### Criterios de aceptación

1. Un paso recibe una tabla de una columna con nombres de productos y los agrega uno por uno.
2. El contador del carrito muestra exactamente la cantidad agregada.
3. En la pantalla del carrito aparecen esos nombres, ni uno más ni uno menos (el orden no importa).
4. Quitar un producto baja el contador en 1.
5. Quitar todos los productos hace desaparecer el contador.
6. Los botones se encuentran por el **nombre del producto**, no por su id.

### Punto de partida

```gherkin
# language: es
@ejercicio2
Característica: Carrito de compras

  Antecedentes:
    Dado que inicié sesión como "standard_user"

  Escenario: El carrito refleja lo que agrego y lo que quito
    Cuando agrego al carrito los productos:
      | Sauce Labs Backpack     |
      | Sauce Labs Bike Light   |
      | Sauce Labs Bolt T-Shirt |
    Entonces el carrito indica 3 productos
    Cuando abro el carrito
    Entonces el carrito contiene exactamente esos productos
    Cuando quito "Sauce Labs Bike Light" del carrito
    Entonces el carrito indica 2 productos
    Y el carrito contiene exactamente esos productos

  Escenario: Al vaciar el carrito desaparece el contador
    Dado que agregué al carrito "Sauce Labs Backpack" y "Sauce Labs Onesie"
    Cuando quito "Sauce Labs Backpack" del carrito
    Y quito "Sauce Labs Onesie" del carrito
    Entonces el carrito no muestra contador
```

### Pistas

- Tabla de una columna: `tabla.raw().flat()` devuelve `['Sauce Labs Backpack', 'Sauce Labs Bike Light', ...]`.
- Botón de un producto por su nombre:
  `page.locator('[data-test="inventory-item"]', { hasText: nombre }).getByRole('button', { name: 'Add to cart' })`.
  Ojo: sin `name`, `getByRole('button')` encuentra **tres** elementos (la imagen y el título también son
  botones) y Playwright falla con *strict mode violation*.
- Contador: `[data-test="shopping-cart-badge"]`. Ícono del carrito: `[data-test="shopping-cart-link"]`.
  Nombres en el carrito: `[data-test="inventory-item-name"]`.
- Para recordar qué agregaste, guarda la lista en el World (`this.productos`), no en una variable global.
- Que algo no existe: `await expect(locator).not.toBeVisible()`.

---

## Ejercicio 3 · ¿El ordenamiento ordena?

**Sesión 2** · Screenplay · dificultad 3 de 5

### Objetivo

No basta con elegir "precio de menor a mayor" y ver que la página no falló. El actor tiene que **leer el
catálogo y comprobar el orden**, con una `Question` que sirva para los cuatro criterios (y que en el
ejercicio 5 encontrará un bug).

### Criterios de aceptación

1. Un *Esquema del escenario* cubre las 4 opciones: `az`, `za`, `lohi` y `hilo`.
2. Ordenar es una `Task` (o una `Interaction`) del actor; los steps no usan `page` ni selectores.
3. Existe una `Question` reutilizable que lee los nombres o los precios tal como se ven y los compara con una
   copia ordenada por el propio código (`"$7.99"` se convierte en `7.99`).
4. Ningún valor esperado está escrito a mano en el `.feature` ni en el código.
5. Si falla, el mensaje muestra la lista obtenida y la esperada.

### Punto de partida

```gherkin
# language: es
@ejercicio3
Característica: Ordenar el catálogo

  Esquema del escenario: Ordenar el catálogo por <criterio>
    Dado que inicié sesión como "standard_user"
    Cuando ordeno los productos por "<criterio>"
    Entonces los productos quedan ordenados por "<criterio>"

    Ejemplos:
      | criterio |
      | az       |
      | za       |
      | lohi     |
      | hilo     |
```

### Pistas

- Selector del orden: `[data-test="product-sort-container"]` (con guiones). Se elige con `selectOption('za')`.
- Nombres: `[data-test="inventory-item-name"]`. Precios: `[data-test="inventory-item-price"]`.
  Todos los textos de una lista: `locator.allInnerTexts()`.
- Ordenar una copia sin tocar la original: `[...lista].sort((a, b) => a - b)` para números y
  `[...lista].sort((a, b) => a.localeCompare(b))` para textos.
- Mensaje propio en una aserción: `expect(obtenido, 'El catálogo no está ordenado').toEqual(esperado)`.
- La pregunta puede devolver un objeto `{ obtenido, esperado }`: así el step solo compara.

---

## Ejercicio 4 · Una compra completa que cuadra

**Sesión 3** · Screenplay · dificultad 4 de 5

### Objetivo

Automatizar el flujo crítico de la tienda (catálogo → carrito → datos de envío → resumen → confirmación) con
una tarea compuesta `CompletarCompra`, y verificar con preguntas que **los montos cuadran**.

### Criterios de aceptación

1. `CompletarCompra` es una `Task` formada por otras tareas e interacciones; se lee como el flujo de negocio.
2. Los datos del comprador llegan por una tabla de Gherkin de dos columnas (nombre, apellido, código postal).
3. En el resumen: subtotal = suma de los precios; impuesto = 8 % del subtotal (redondeado a 2 decimales);
   total = subtotal + impuesto.
4. La confirmación muestra *Thank you for your order!*
5. Escenario negativo: sin datos de envío la app muestra *First Name is required* y no avanza.
6. El escenario feliz lleva `@smoke`: es el que correrá la CI en cada Pull Request.

### Punto de partida

```gherkin
# language: es
@ejercicio4
Característica: Compra de punta a punta

  Antecedentes:
    Dado que inicié sesión como "standard_user"

  @smoke
  Escenario: Comprar dos productos
    Dado que agregué al carrito "Sauce Labs Backpack" y "Sauce Labs Bike Light"
    Cuando completo la compra con los datos:
      | nombre       | Ana    |
      | apellido     | Torres |
      | codigoPostal | 15001  |
    Entonces el resumen muestra subtotal, impuesto y total correctos
    Y veo la confirmación "Thank you for your order!"

  Escenario: No se puede pagar sin datos de envío
    Dado que agregué al carrito "Sauce Labs Backpack"
    Cuando intento pagar sin datos de envío
    Entonces veo el mensaje de error "First Name is required"
    Y sigo en el paso de datos de envío
```

### Pistas

- Tabla clave | valor: `tabla.rowsHash()` devuelve `{ nombre: 'Ana', apellido: 'Torres', codigoPostal: '15001' }`.
- Selectores (`data-test`): `checkout`, `firstName`, `lastName`, `postalCode`, `continue`, `finish`,
  `inventory-item-price`, `subtotal-label`, `tax-label`, `total-label`, `complete-header`.
- Dato verificado: mochila ($29.99) + luz ($9.99) → subtotal **$39.98**, impuesto **$3.20**, total **$43.18**.
- El resumen desaparece al pulsar *Finish*. Si la tarea llega hasta la confirmación, el actor tiene que
  **anotar** lo que vio en el resumen antes de seguir, para que el *Entonces* lo revise.
- Para comparar decimales: `expect(total).toBeCloseTo(subtotal + impuesto, 2)`.

---

## Ejercicio 5 · Caza de bugs con `problem_user`

**Sesión 3** · Screenplay · dificultad 5 de 5

### Objetivo

SauceDemo tiene usuarios con fallas a propósito. Corre tus escenarios de los ejercicios 2 a 4 con
`problem_user`, encuentra lo que se rompe y documéntalo como lo haría un QA: un escenario que lo demuestra
y un reporte que cualquiera puede reproducir.

### Criterios de aceptación

1. Al menos **tres** bugs distintos, cada uno con un escenario automatizado que falla por la causa correcta.
2. El usuario se parametriza con *Esquema del escenario*: la misma verificación pasa con `standard_user`
   y falla con `problem_user`.
3. Lo que falla por un bug de la aplicación lleva la etiqueta `@bug`.
4. `npm test` **sigue en verde**: los `@bug` no corren por defecto. Explica en el PR cómo lo resolviste
   y con qué comando se ejecutan.
5. Un `BUGS.md` en la raíz con, por cada bug: título, usuario, pasos, resultado esperado, resultado obtenido,
   captura y severidad.
6. La captura de cada falla sale sola del hook `After` (no tomada a mano).

### Pistas, sin spoilers

- Mira con atención las imágenes del catálogo.
- Tu ejercicio 3 ya sabe si el ordenamiento de verdad ordena.
- ¿Todos los botones *Add to cart* hacen algo?
- En el checkout, ¿lo que escribes queda en el campo donde lo escribiste?
- ¿Cuánto tarda en entrar `performance_glitch_user`? ¿Tus pruebas lo toleran sin esperas fijas?
- Las etiquetas también se pueden poner sobre un bloque `Ejemplos:` y no solo sobre el escenario.
- En `cucumber.js`, la opción `tags` acepta expresiones como `'not @bug'`, y cada `export` es un perfil
  que se elige con `--profile`.

---

## Cómo entregar

Una rama y un Pull Request a `develop` **por sesión** ([paso a paso](04-git-y-github.md#6-el-flujo-de-cada-ejercicio)):

```bash
git switch develop
git pull
git switch -c feature/s2-ana-torres
# ... programas ...
npm run typecheck
npm test
git add .
git commit -m "feat: agrega pregunta de ordenamiento del catálogo"
git push -u origin feature/s2-ana-torres
```

En la descripción del Pull Request:

- Qué ejercicios incluye y con qué comando se ejecuta cada uno (`npm test -- --tags @ejercicio3`).
- La salida final de `npm test` (`N scenarios (N passed)`).
- Ejercicio 5: el enlace a tu `BUGS.md` y el comando que corre los `@bug`.

La CI tiene que quedar en verde. El instructor revisa con la rúbrica del [sílabo](05-silabo.md#cómo-se-evalúa-cada-sesión).

---

Anterior: [Sílabo](05-silabo.md) · [Índice](README.md) · Material de clase: [presentaciones en PDF](pdf/)
