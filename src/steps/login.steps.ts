import { Given, When, Then } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world';
import { LoginPage } from '../pages/LoginPage';

Given('que estoy en la página de login', async function (this: CustomWorld) {
  await new LoginPage(this.page).abrir();
});

When('ingreso con el usuario {string} y la clave {string}', async function (this: CustomWorld, usuario: string, clave: string) {
  await new LoginPage(this.page).ingresar(usuario, clave);
});

Then('veo el catálogo de productos', async function (this: CustomWorld) {
  await expect(this.page.locator('[data-test="title"]')).toHaveText('Products');
});

Then('veo el mensaje de error {string}', async function (this: CustomWorld, mensaje: string) {
  await expect(new LoginPage(this.page).mensajeError()).toContainText(mensaje);
});
