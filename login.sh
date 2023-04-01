#!/bin/bash

for var in NAUTA_USER NAUTA_PASS; do
  if [ -z "${!var:-}" ]; then
    echo "Error! La variable $var no está definida."
    exit 1
  fi
done

######################################################################
# Script Configuration
######################################################################
TARGET_URL="https://secure.etecsa.net:8443/LoginServlet"

# Set the internet server to be verified (Change this as needed) detectportal.firefox.com is a good alternative
VERIFICATION_URL="captive.apple.com"
VERIFICATION_RESPONSE="<HTML><HEAD><TITLE>Success</TITLE></HEAD><BODY>Success</BODY></HTML>"

# Verification Timeout (seconds)
VERIFICATION_TIMEOUT_IN_SECONDS=15

# POST Data
user_data="username=${NAUTA_USER}"
passwd_data="password=${NAUTA_PASS}"

# Checks if internet is reachable
if [[ $(curl -m ${VERIFICATION_TIMEOUT_IN_SECONDS} -s ${VERIFICATION_URL}) != "${VERIFICATION_RESPONSE}" ]]; then
  # Internet not detected,
  # post username and password to URL
  echo "Internet NO responde. Intentando conectar..."

  if curl -m ${VERIFICATION_TIMEOUT_IN_SECONDS} -s -k ${TARGET_URL} &>/dev/null; then
    curl -s -k ${TARGET_URL} --data-urlencode "${user_data}" --data-urlencode "${passwd_data}" | grep "alert" | grep -o '\(".*"\)'
    echo "El enlace con ETECSA responde correctamente. Verificando que ya se haya conectado Internet..."

    if [[ $(curl -m ${VERIFICATION_TIMEOUT_IN_SECONDS} -s ${VERIFICATION_URL}) == "${VERIFICATION_RESPONSE}" ]]; then
      echo "Internet se ha conectado CORRECTAMENTE"
    else
      echo "No ha sido posible iniciar sesión. Continuaremos intentando conectar..."
      exit 1
    fi

  else
    echo "No hay conexion con ETECSA en estos momentos. No ha sido posible iniciar sesión. Continuaremos intentando conectar..."
    exit 1
  fi

else
  # Internet active
  echo "Internet responde correctamente al PING. Usted esta conectado"
fi
