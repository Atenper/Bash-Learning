#!/bin/bash

# AndresTenlladoPerez

make_tar_gz() {
    echo "Introduce el nombre del directorio: "
    read directorio
    if [ -d "$directorio" ]; then
        fecha=$(date +%F)
        tar -czf "${fecha}${directorio}.tar.gz" "$directorio"
        echo "Archivo comprimido creado: ${fecha}${directorio}.tar.gz"
    else
        echo "El directorio $directorio no existe."
    fi
}


make_exec() {
    echo "Introduce el nombre del archivo a hacer ejecutable: "
    read archivo
    if [ -f "$archivo" ]; then
        chmod +x "$archivo"
        echo "El archivo ahora puede ser ejecutado"
    else
        echo "El archivo $archivo no existe."
    fi
}

make_log() {
    echo "Introduce la ruta completa del archivo de log:"
    read ruta_log


    echo "Introduce el nombre del archivo de salida (sin extensión .txt):"
    read nombre_archivo

    cat "$ruta_log" > "$nombre_archivo.txt"


    echo "El contenido del log ha sido redireccionado a $nombre_archivo.txt"

}

while true; do
    echo "Selecciona una opción:"
    echo "1. Crear un archivo tar.gz del directorio"
    echo "2. Convertir un archivo en ejecutable"
    echo "3. Redirigir el contenido de un log a un archivo .txt"
    echo "4. Salir"
    read opcion

    case $opcion in
        1)
            make_tar_gz
            ;;
        2)
            make_exec
            ;;
        3)
            make_log
            ;;
        4)
            echo "Saliendo del script..."
            break
            ;;
        *)
            echo "Opción inválida, por favor selecciona una opción válida."
            ;;
    esac
done
