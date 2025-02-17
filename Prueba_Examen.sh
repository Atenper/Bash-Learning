#!/bin/bash

#AndresTenlladoPerez

mostrar_impresoras() {
    echo "Mostrando impresoras disponibles..."
    lpstat -p -d
}


while true; do
    echo "Seleccione una opción:"
    echo "1. Gestión de usuarios"
    echo "2. Gestión de red"
    echo "3. Gestion de firewall"
    echo "4. Mostrar la lista de impresoras"
    echo "5. Salir"
    read opcion

    case $opcion in
    1)
        ./ges_user.sh
        ;;
    2)
        ./red_scan.sh
        ;;
    3)
        ./ges_firewall.sh
        ;;
    4)
        mostrar_impresoras
        ;;
    5)
        echo "Saliendo del script..."
        break
        ;;
    *)
        echo "Opción no válida"
        ;;
    esac
done
