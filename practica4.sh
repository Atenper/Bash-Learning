#!/bin/bash

#AndresTenlladoPerez
make_archivo(){
    netstat > salida-netstat.txt
    echo "Archivo salida-netstat.txt creado"
}

make_establised(){
    grep ESTABLISHED salida-netstat.txt > salida-netstat-establecido.txt
    echo "Archivo salida-netstat-establecido.txt creado"
}

count_con(){
    establecidas=$(grep -c ESTABLISHED salida-netstat.txt)
    time_wait=$(grep -c TIME_WAIT salida-netstat.txt)
    echo "Conexiones ESTABLECIDAS: $establecidas"
    echo "Conexiones TIME_WAIT: $time_wait"
}


search_unsafe(){
    for ip in $(grep -E "^\S+\s+\S+\s+.*:80\s+" salida-netstat.txt | awk '{print $5}' | cut -d: -f1 | sort | uniq); do
        if [ -n "$ip" ]; then
        echo "IP de conexión web no segura: $ip"
    fi
    done
}


while true; do
    echo "Selecciona una opción:"
    echo "1. Muestra las conexiones de tu red y guarda la salida en un fichero salida-netstat.txt "
    echo "2. Haz un filtro del fichero salida-netstat.txt cogiendo únicamente las líneas de las conexiones ESTABLECIDAS. Guarda la salida en un fichero llamado salida-netstat-establecido.txt"
    echo "3. Muestra por pantalla cuantas conexiones están ESTABLECIDO y cuantas en TIME_WAIT. Hay un comando en bash para contar líneas en ficheros."
    echo "4. Muestra la ip de la conexiones web no seguras"
    echo "5. Salir"
    read opcion

    case $opcion in
        1)
            make_archivo
            ;;
        2)
            make_establised
            ;;
        3)
            count_con
            ;;
        4)
            search_unsafe
            ;;
        5)
            echo "Saliendo del script..."
            break
            ;;
        *)
            echo "Opción inválida, por favor selecciona una opción válida."
            ;;
    esac
done
