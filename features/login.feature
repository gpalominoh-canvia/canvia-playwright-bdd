# language: es
Característica: Inicio de sesión en SauceDemo
  Como comprador registrado
  Quiero iniciar sesión
  Para ver el catálogo de productos

  Antecedentes:
    Dado que estoy en la página de login

  @smoke
  Escenario: Login exitoso
    Cuando ingreso con el usuario "standard_user" y la clave "secret_sauce"
    Entonces veo el catálogo de productos

  @regresion
  Esquema del escenario: Login rechazado
    Cuando ingreso con el usuario "<usuario>" y la clave "<clave>"
    Entonces veo el mensaje de error "<mensaje>"

    Ejemplos:
      | usuario         | clave        | mensaje                                  |
      | locked_out_user | secret_sauce | Sorry, this user has been locked out     |
      | standard_user   | incorrecta   | Username and password do not match       |
