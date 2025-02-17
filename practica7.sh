#!/bin/bash

#AndresTenlladoPerez
bloquear_paquetes_entrantes() {
    echo "Introduce la IP del exterior para bloquear el acceso al servidor:"
    read ip_exterior
    sudo iptables -A INPUT -s $ip_exterior -j DROP
    sudo iptables-save > /etc/iptables/rules.v4
    echo "Se ha bloqueado el acceso desde la IP $ip_exterior."
}

bloquear_rango_ip_salida() {

    echo "Introduce el rango de IPs:"
    read rango_ips
    sudo iptables -A OUTPUT -d $rango_ips -j REJECT
    sudo iptables-save > /etc/iptables/rules.v4
    echo "Se ha bloqueado el acceso a las IPs del rango $rango_ips."
}

bloquear_facebook() {
    facebook_ip=$(dig +short www.facebook.com | head -n 1)
    if [ -z "$facebook_ip" ]; then
        echo "No se pudo obtener la IP de www.facebook.com."
        exit 1
    fi
    sudo iptables -A OUTPUT -d $facebook_ip -j REJECT
    sudo iptables-save > /etc/iptables/rules.v4
    echo "Se ha bloqueado el acceso a www.facebook.com ($facebook_ip)."
}

# Menú para ejecutar las acciones
echo "Seleccione una opción:"
echo "1. Bloquear paquetes entrantes desde una IP exterior"
echo "2. Bloquear paquetes salientes de un rango de IP"
echo "3. Bloquear acceso a www.facebook.com"
echo "4. Salir"
read opcion

case $opcion in
    1)
        bloquear_paquetes_entrantes
        ;;
    2)
        bloquear_rango_ip_salida
        ;;
    3)
        bloquear_facebook
        ;;
    4)
        echo "Saliendo..."
        exit 0
        ;;
    *)
        echo "Opción no válida"
        ;;
esac
