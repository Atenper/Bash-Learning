#!/bin/bash

# Función para cortar el tráfico saliente hacia un dominio web solicitado
cortar_trafico_saliendo() {
    echo "Introduce el dominio al cual deseas cortar el tráfico saliente (ejemplo: ejemplo.com):"
    read dominio

    # Comprobar si el dominio es válido resolviendo la IP
    sudo ip_dominio=$(getent hosts "$dominio" | awk '{ print $1 }')
    if [ -z "$ip_dominio" ]; then
        echo "No se pudo resolver el dominio $dominio."
        return
    fi

    echo "Cortando el tráfico saliente hacia $dominio ($ip_dominio)..."

    # Usar iptables para cortar el tráfico saliente hacia el dominio
    sudo iptables -A OUTPUT -d "$ip_dominio" -j REJECT
    if [ $? -eq 0 ]; then
        echo "Tráfico saliente hacia $dominio ($ip_dominio) ha sido cortado."
    else
        echo "Error al cortar el tráfico."
    fi
}

# Función para cortar el tráfico entrante hacia el servidor (por IP)
cortar_trafico_entrante() {
    echo "Introduce la IP de tu servidor para cortar el tráfico entrante:"
    read ip_servidor

    # Comprobar si la IP es válida
    if ! echo "$ip_servidor" | grep -Pq '^\d{1,3}(\.\d{1,3}){3}$'; then
        echo "La IP proporcionada no es válida."
        return
    fi

    echo "Cortando el tráfico entrante hacia el servidor $ip_servidor..."

    # Usar iptables para cortar el tráfico entrante hacia el servidor
    sudo iptables -A INPUT -d "$ip_servidor" -j REJECT
    if [ $? -eq 0 ]; then
        echo "Tráfico entrante hacia $ip_servidor ha sido cortado."
    else
        echo "Error al cortar el tráfico."
    fi
}

# Función principal que muestra el menú
mostrar_menu() {
    clear
    echo "Menú de Gestión del Firewall"
    echo "1. Cortar el tráfico saliente hacia un dominio web"
    echo "2. Cortar el tráfico entrante hacia un servidor"
    echo "3. Salir"
    echo "Introduce una opción (1-3):"
    read opcion

    case $opcion in
        1)
            cortar_trafico_saliendo
            ;;
        2)
            cortar_trafico_entrante
            ;;
        3)
            echo "Saliendo..."
            exit 0
            ;;
        *)
            echo "Opción inválida."
            ;;
    esac
}

# Bucle principal que muestra el menú
while true; do
    mostrar_menu
    echo "Presiona Enter para continuar..."
    read
done
