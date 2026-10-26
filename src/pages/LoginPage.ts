import { Page } from '@playwright/test';

export class LoginPage {
  constructor(private readonly page: Page) {}

  async abrir() {
    await this.page.goto('/');
  }

  async ingresar(usuario: string, clave: string) {
    await this.page.locator('[data-test="username"]').fill(usuario);
    await this.page.locator('[data-test="password"]').fill(clave);
    await this.page.locator('[data-test="login-button"]').click();
  }

  mensajeError() {
    return this.page.locator('[data-test="error"]');
  }
}
