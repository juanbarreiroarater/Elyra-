#!/bin/bash
# Script de identidad bilingüe para Elyra

# Detectar idioma (si contiene 'en' es inglés, sino español por defecto)
if [[ "$LANG" == *'en'* ]]; then
    # English Texts
    TXT_WELCOME="   Welcome to Elyra - AI Configuration    "
    TXT_NAME="Name for your Virtual Assistant: "
    TXT_GENDER="AI Gender (Male/Female/Other): "
    TXT_DONE="Configuration saved. Now my name is"
else
    # Textos en Español
    TXT_WELCOME="   Bienvenido a Elyra - Configuración de IA    "
    TXT_NAME="Nombre para tu Asistente Virtual: "
    TXT_GENDER="Género de la IA (Masculino/Femenino/Otro): "
    TXT_DONE="Configuración guardada. Ahora me llamo"
fi

echo "------------------------------------------------"
echo "$TXT_WELCOME"
echo "------------------------------------------------"

# Pedir los datos al usuario
read -p "$TXT_NAME" NOMBRE_IA
read -p "$TXT_GENDER" GENERO_IA

# Actualizar MariaDB directamente
mysql -u root -e "USE elyra_core; UPDATE ia_config SET nombre_ia='$NOMBRE_IA', genero_ia='$GENERO_IA' WHERE id=1;"

echo "------------------------------------------------"
echo "$TXT_DONE $NOMBRE_IA."
echo "------------------------------------------------"
