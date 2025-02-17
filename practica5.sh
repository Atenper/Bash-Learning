#!/bin/bash

#AndresTenlladoPerez
while true; do
    echo "Seleccione una opción:"
    echo "1. Gestión de usuarios"
    echo "2. Gestión de red"
    echo "3. Salir"
    read opcion

    case $opcion in
    1)
        ./gestion_usuarios.sh
        ;;
    2)
        ./gestion_red.sh
        ;;
    3)
        echo "Saliendo del script..."
        break
        ;;
    *)
        echo "Opción no válida"
        ;;
    esac
done
