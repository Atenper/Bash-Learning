#!/bin/bash

#AndresTenlladoPerez
listip(){
    netstat -n -p | grep SYN_REC | awk '{print $5}' | awk -F: '{print $1}'
}
listipsynrec(){
    netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n
}

netcount(){
    netstat -anp |grep 'tcp|udp' | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n
}

listipconected(){
    netstat -ntu | grep ESTAB | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr
}

listip80(){
    netstat -plan|grep :80|awk {'print $5'}|cut -d: -f 1|sort|uniq -c|sort -nk 1
}

block(){
    echo "Introduce la ip que ataca tu servidor"
    read ip
    iptables -A INPUT 1 -s $ip -j DROP/REJECT
    echo "Ip bloqueada"
}

while true; do
    echo "Seleccione una opción:"
    echo "1. Lista todas las direcciones IP involucradas en vez de simplemente contarlas"
    echo "2. Lista todas las direcciones IP únicas del nodo que envía el estado de conexión SYN_REC"
    echo "3. Netstat para calcular y contar el número de conexiones que hace cada dirección IP al servidor"
    echo "4. Lista el número de conexiones IP conectadas al servidor usando el protocolo TCP o UDP"
    echo "5. Muestra y lista las direcciones IP y la cantidad de conexiones al puerto 80 en el servidor"
    echo "6. Bloquear conexiones al servidor"
    echo "7. Salir"
    read opcion

    case $opcion in
    1)
        listip
        ;;
    2)
        listipsynrec
        ;;
    3)
        netcount
        ;;
    4)
        listipconected
        ;;
    5)
        listip80
        ;;
    6)
        block
        ;;
    7)
        echo "Saliendo del script..."
        break
        ;;
    *)
        echo "Opción no válida"
        ;;
    esac
done
