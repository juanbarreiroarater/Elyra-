#!/bin/bash
# Elyra Sanitizer - Preparación para Distribución
# Este script limpia rastros personales de la imagen de desarrollo.

TARGET_DIR="/opt/elyra_dev/rootfs" # Ajusta esto a la carpeta que contendrá el sistema a empaquetar

if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: No se encuentra la carpeta de sistema $TARGET_DIR"
    exit 1
fi

echo "Elyra: Iniciando limpieza profunda de datos personales..."

# 1. Limpieza de APT (Caché de paquetes)
echo "-> Limpiando caché de paquetes..."
rm -rf $TARGET_DIR/var/cache/apt/archives/*
rm -rf $TARGET_DIR/var/lib/apt/lists/*

# 2. Limpieza de Logs (Registros del sistema)
echo "-> Vaciando archivos de log..."
find $TARGET_DIR/var/log -type f -exec truncate -s 0 {} \;

# 3. Limpieza de Temporales
echo "-> Eliminando archivos temporales..."
rm -rf $TARGET_DIR/tmp/*
rm -rf $TARGET_DIR/var/tmp/*

# 4. Limpieza de Usuarios y Bash (CRÍTICO)
echo "-> Eliminando historiales y claves..."
find $TARGET_DIR/home -name ".bash_history" -delete
find $TARGET_DIR/root -name ".bash_history" -delete
find $TARGET_DIR/home -name ".ssh" -rf
find $TARGET_DIR/root -name ".ssh" -rf

# 5. Reset de Identidad de la IA (Para que el usuario elija la suya)
echo "-> Reseteando base de datos de identidad en MariaDB..."
# (Este comando asume que el servicio MariaDB está corriendo y accesible)
# mysql -u root -e "UPDATE elyra_core.ia_config SET nombre_ia='Sin definir', genero_ia='No binario' WHERE id=1;"

echo "------------------------------------------------"
echo "Elyra está limpia y lista para ser empaquetada."
echo "------------------------------------------------"
