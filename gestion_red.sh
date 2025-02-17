#!/bin/bash

#AndresTenlladoPerez
netstat_notsecure(){
    netstat -tuln | grep ":80"
}
netstat_secure(){
    netstat -tuln | grep ":443"
}
save_netstat(){
        netstat -u > conexiones_udp.txt
        echo "Las conexiones UDP han sido almacenadas en 'conexiones_udp.txt'."
}
while true; do
    echo "Seleccione una opción de gestión de red:"
    echo "1. Dirección IP de equipos que se están conectando a una conexión no segura"
    echo "2. Mostrar conexiones estableciéndose a través de un puerto seguro"
    echo "3. Almacenar en un fichero todas las conexiones del protocolo UDP"
    echo "4. Salir"
    read opcion_red


    case $opcion_red in
    1)
        netstat_notsecure
        ;;
    2)
        netstat_secure
        ;;
    3)
        save_netstat
        ;;
    4)
        echo "Saliendo del script..."
        break
        ;;
    *)
        echo "Opción no válida"
        ;;
    esac
done
