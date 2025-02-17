#!/bin/bash

# Función para almacenar las conexiones en espera (TIME_WAIT) en un archivo
almacenar_conexiones() {
    echo "Almacenando las conexiones en espera (TIME_WAIT) en el archivo salida_red.txt..."
    sudo netstat -an | grep TIME_WAIT > salida_red.txt
    echo "Conexiones almacenadas correctamente en salida_red.txt."
}

# Función para mostrar la IP de las conexiones web no seguras (puertos 80 y 443)
mostrar_ip_no_seguras() {
    echo "Mostrando las IPs de conexiones web no seguras (puerto 80 o 443)..."
    grep -E '80|443' salida_red.txt | awk '{print $5}' | cut -d: -f1 | sort | uniq
}

# Función para mostrar el contenido del archivo de conexiones
mostrar_contenido_fichero() {
    echo "Contenido del archivo salida_red.txt:"
    cat salida_red.txt
}

# Función para detectar el sistema operativo y puertos de un rango de IPs
detectar_sistema_y_puertos() {
    echo "Detectando sistema operativo y puertos de los equipos de 192.168.8.12 a 192.168.8.23..."
    for ip in {12..23}; do
        echo "Escaneando 192.168.8.$ip..."
        sudo nmap -O 192.168.8.$ip
    done
}

# Función para mostrar la información de un usuario
mostrar_info_usuario() {
    echo "Introduce el nombre del usuario:"
    read usuario
    echo "Mostrando información de usuario $usuario..."

    # Comprobar si el usuario existe
    if id "$usuario" &>/dev/null; then
        # Mostrar información del usuario
        finger "$usuario"
    else
        echo "El usuario $usuario no existe en el sistema."
    fi
}

# Función principal que muestra el menú
mostrar_menu() {
    clear
    echo "Menú de Análisis de Red"
    echo "1. Almacenar conexiones TIME_WAIT en salida_red.txt"
    echo "2. Mostrar IPs de conexiones web no seguras"
    echo "3. Mostrar contenido del fichero salida_red.txt"
    echo "4. Detectar sistema operativo y puertos de la red (192.168.8.12-23)"
    echo "5. Mostrar información de un usuario"
    echo "6. Salir"
    echo "Introduce una opción (1-6):"
    read opcion

    case $opcion in
        1)
            almacenar_conexiones
            ;;
        2)
            mostrar_ip_no_seguras
            ;;
        3)
            mostrar_contenido_fichero
            ;;
        4)
            detectar_sistema_y_puertos
            ;;
        5)
            mostrar_info_usuario
            ;;
        6)
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

