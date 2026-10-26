#!/bin/sh
set -e

# El repositorio llega montado desde Windows: Git debe confiar en esa carpeta.
git config --global --add safe.directory /workspace

# node_modules vive en un volumen de Docker (los binarios de Windows no sirven en Linux).
if [ ! -f node_modules/.package-lock.json ]; then
  echo "Instalando dependencias (npm ci)..."
  npm ci
fi

exec code-server \
  --bind-addr 0.0.0.0:8080 \
  --auth none \
  --disable-telemetry \
  /workspace
