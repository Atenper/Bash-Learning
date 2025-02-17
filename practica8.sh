#!/bin/bash

#AndresTenlladoPerez
show_ports(){
    netstat -tuln
}
show_active_hosts(){
    echo "Por favor, ingresa la IP o el rango:"
    read ip
    nmap -sP $ip
}

show_op(){
    echo "Por favor, ingresa la IP o el rango:"
    read ip
    sudo nmap -O $ip
}

1_3_out(){
    echo "Por favor, ingresa la IP o el rango:"
    read ip
    netstat -tuln > salida_host.txt
    sudo nmap -O $ip >> salida_host.txt
}

search_ip(){
    echo "Por favor, ingresa la IP o el rango:"
    read ip
    grep -A 13 "$ip" salida_host.txt
}
while true; do
    # Menú para ejecutar las acciones
    echo "Seleccione una opción:"
    echo "1. Muestra el estado de los puertos, con su protocolo de los host de tu red"
    echo "2. Muestra los hosts activos de tu red"
    echo "3. Identifca los Sistemas operativos de los hosts de tu red"
    echo "4. Manda la información de los puntos 1 y 3 a un fichero salida_host.txt"
    echo "5. Busca toda la información relativa a un host, cuya IP solicitaras por pantalla en el fichero salida_host.txt"
    echo "6. Salir"
    read opcion

    case $opcion in
        1)
            show_ports
            ;;
        2)
            show_active_hosts
            ;;
        3)
            show_op
            ;;
        4)
            1_3_out
            ;;
        5)
            search_ip
            ;;
        6)
            echo "Saliendo..."
            exit 0
            ;;
        *)
            echo "Opción no válida"
            ;;
    esac
done
