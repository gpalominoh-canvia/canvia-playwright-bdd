# Entorno listo para el curso: Node + Playwright (Chromium) + VS Code en el navegador (code-server).
# La versión de la imagen debe coincidir con @playwright/test del package-lock.json.
FROM mcr.microsoft.com/playwright:v1.64.1-noble

ARG CODE_SERVER_VERSION=4.96.4

RUN apt-get update \
 && apt-get install -y --no-install-recommends curl git ca-certificates \
 && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://code-server.dev/install.sh \
    | sh -s -- --method=standalone --prefix=/usr/local --version=${CODE_SERVER_VERSION}

# Mismas extensiones que pide el manual de instalación.
RUN for ext in ms-playwright.playwright CucumberOpen.cucumber-official; do \
      code-server --install-extension "$ext" || echo "AVISO: no se pudo instalar $ext"; \
    done

COPY docker/alumnos/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /workspace
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
