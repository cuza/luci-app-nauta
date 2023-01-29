#!/bin/bash

for var in NAUTA_USER NAUTA_PASS; do
  if [ -n "${!var:-}" ]; then
    echo "$var tiene asignado ${!var}"
  else
    echo "Error! La variable $var no está definida."
    exit 1
  fi
done

######################################################################
# Script Configuration
######################################################################
TARGET_URL="https://secure.etecsa.net:8443/LoginServlet"

# Set the internet server to be verified (Change this as needed)
VERIFICATION_SERVER="8.8.8.8"

# Verification Timeout (seconds)
VERIFICATION_TIMEOUT_IN_SECONDS=1

# User Data
data="username="${NAUTA_USER}"&&password="${NAUTA_PASS}

# Checks if internet is reachable
ping -c 1 -W ${VERIFICATION_TIMEOUT_IN_SECONDS} ${VERIFICATION_SERVER} &>/dev/null

if [[ $? -ne 0 ]]; then
  # Internet not detected,
  # post username and password to URL
  echo "Internet NO responde. Intentando conectar..."

  if ping -c 1 -W 10 secure.etecsa.net &>/dev/null; then
    curl -k ${TARGET_URL} -d "${data}"
    echo "El enlace con ETECSA responde correctamente. Verificando que ya se haya conectado Internet..."

    if ping -c 1 -W 10 ${VERIFICATION_SERVER} &>/dev/null; then
      echo "Internet se ha conectado CORRECTAMENTE"
    else
      /etc/init.d/cron stop
      echo "No fue posible conectarse. Deteniendo el servicio CRON"
      exit 1
    fi

  else
    echo "No hay conexion con ETECSA en estos momentos. No ha sido posible iniciar sesion. Continuaremos intentando conectar..."
    exit 1
  fi

else
  # Internet active
  echo "Internet responde correctamente al PING. Usted esta conectado"
fi
