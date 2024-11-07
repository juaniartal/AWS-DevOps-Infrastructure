#!/bin/bash

if [ -z "$1" ]; then
  echo "Uso: ./connect_ec2.sh <IP_PUBLICA>"
  echo "Por favor, pase la IP pública de la instancia como argumento para su funcionamiento."
  exit 1
else
  # le asigno la ip a la variable ip publica
  ip_publica=$1

  # permisos
  sudo chmod 400 privatekey

  # conecto
  echo "Conectando a la instancia EC2 en $ip_publica..."
  ssh ec2-user@$ip_publica -p 22 -i privatekey
fi

