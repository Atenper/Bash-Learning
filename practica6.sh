#!/bin/bash
# Andres Tenllado Perez - Practica 2
#Comando nload
nload(){
    echo "Ejecutando el comando nload"
    sudo nload
}

#Comando iftop
iftop(){
    echo "Ejecutando el comando iftop"
    sudo iftop
}

#Comando slurm
slurm(){
    read -p "Introduce el nombre de la interfaz: " nombre
    sudo slurm -i $nombre
}

#Redericciona la salida del comando netload a un fichero con la fecha actual
redirect_netload(){
    echo "Redirigiendo la salida de nload a un archivo con la fecha actual"
    sudo nload -t > "nload_output_$(date +\%F_\%T).log"
    echo "La salida de nload ha sido guardada en el archivo 'nload_output_$(date +\%F_\%T).log'"
}

grep_c(){
    read -p "Introduce la IP a consultar: " user_ip
    echo "Buscando conexiones realizadas por la IP $user_ip..."
    echo "Número de conexiones realizadas por la IP $user_ip:" > ip_connections.txt
    netstat -ant | grep "$user_ip" | wc -l >> ip_connections.txt
    echo "Detalles de los paquetes (Origen, Destino, Conexión exitosa):" >> ip_connections.txt
    netstat -ant | grep "$user_ip" >> ip_connections.txt
    echo "Salida redirigida a ip_connections.txt"
    cat ip_connections.txt
}

# Menú principal con el switch case
while true; do
    echo "Selecciona una opción:"
    echo "1) Comando nload"
    echo "2) Comando iftop"
    echo "3) Comando slurm"
    echo "4) Redericciona la salida del comando netload a un fichero con la fecha actual"
    echo "5) Contar conexiones de una IP especifica y mostrar detalles de los paquetes"
    echo "6) Salir"
    read -p "Opción: " opcion

    case $opcion in
        1)
            nload
            ;;
        2)
            iftop
            ;;
        3)
            slurm
            ;;
        4)
            redirect_netload
            ;;
        5)
            grep_c
            ;;
        6)
            echo "Saliendo..."
            break
            ;;
        *)
            echo "Opción no válida. Por favor, selecciona una opción entre 1 y 5."
            ;;
    esac
done
