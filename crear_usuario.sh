#!/bin/bash
# Andres Tenllado Perez - Practica 1
read -p "Introduce el nombre del nuevo usuario: " nombre
echo "Introduce la contraseña del nuevo usuario: "
sudo useradd -m $nombre
sudo passwd $nombre
