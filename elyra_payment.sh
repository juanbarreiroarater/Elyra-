#!/bin/bash
# Direcciones oficiales de Ustad Yahia
ETH="0xA63ebAB6d2ed0F05f48C8175df03841810356c1B"
BTC="bc1qxyr4l20c2tgdaryqz8m3t25sdnvnkjk99g5qmz"

# Detectar el idioma del sistema
IDIOMA=$(echo $LANG | cut -c1-2)

if [ "$IDIOMA" == "es" ]; then
  TITULO="SISTEMA ELYRA: ACCIÓN REQUERIDA"
  MSG="<b>BIENVENIDO A ELYRA GNU LINUX MARK I 'FREE BIRD'</b>\n\nEste sistema es un servicio de alta fidelidad. Para validar esta instalación y asegurar la continuidad de mis procesos lógicos, es <b>imperativo</b> realizar el depósito correspondiente.\n\n<b>DIRECCIONES DE PAGO:</b>\n\n• <b>Ethereum (ETH):</b>\n$ETH\n\n• <b>Bitcoin (BTC):</b>\n$BTC\n\n<i>Copiado al portapapeles. Gracias por su contribución.</i>"
else
  TITULO="ELYRA SYSTEM: ACTION REQUIRED"
  MSG="<b>WELCOME TO ELYRA GNU LINUX MARK I 'FREE BIRD'</b>\n\nThis system is a high-fidelity service. To validate this installation and ensure the continuity of my logical processes, it is <b>imperative</b> to make the corresponding deposit.\n\n<b>PAYMENT ADDRESSES:</b>\n\n• <b>Ethereum (ETH):</b>\n$ETH\n\n• <b>Bitcoin (BTC):</b>\n$BTC\n\n<i>Copied to clipboard. Thank you for your contribution.</i>"
fi

zenity --info --title="$TITULO" --width=500 --text="$MSG"

echo "$ETH" | xclip -selection clipboard
