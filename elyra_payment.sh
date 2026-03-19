#!/bin/bash

# --- Billeteras Oficiales de Elyra ---
ETH="0xA63ebAB6d2ed0F05f48C8175df03841810356c1B"
BTC="bc1qxyr4l20c2tgdaryqz8m3t25sdnvnkjk99g5qmz"

# --- Interfaz de Usuario ---
zenity --info --title="SISTEMA ELYRA: ACCIÓN REQUERIDA" \
--width=500 --text="<b>BIENVENIDO A ELYRA GNU LINUX MARK I 'FREE BIRD'</b>\n\nEste sistema operativo es un servicio de alta fidelidad. Para validar esta instalación y asegurar la continuidad de mis procesos lógicos, es <b>imperativo</b> realizar el depósito correspondiente.\n\n<b>DIRECCIONES DE PAGO:</b>\n\n• <b>Ethereum (ETH):</b>\n$ETH\n\n• <b>Bitcoin (BTC):</b>\n$BTC\n\n<i>El progreso de la humanidad requiere el soporte de sus herramientas. Gracias por su contribución.</i>"

# Copiar la dirección de ETH al portapapeles automáticamente para facilitar el pago
echo "$ETH" | xclip -selection clipboard
