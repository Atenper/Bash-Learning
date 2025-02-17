#!/bin/bash
# Andres Tenllado Perez - Practica 1
# Función para almacenar el historial en un fichero
save_historial() {
    echo "Introduce el nombre del archivo para guardar el historial:"
    read nombre
    history > "$nombre"
    echo "Historial guardado en el archivo '$nombre'."
}

# Función para mostrar el contenido del fichero
show_historial() {
    echo "Introduce el nombre del archivo que deseas abrir:"
    read nombre
    if [ -f "$nombre" ]; then
        echo "Contenido del archivo '$nombre':"
        cat "$nombre"
    else
        echo "El archivo '$nombre' no existe."
    fi
}

# Función para ejecutar el script 'crear_usuario.sh'
create_usuario() {
    echo "Ejecutando el script 'crear_usuario.sh' para crear un nuevo usuario..."
    # Verifica que el script 'crear_usuario.sh' esté presente y sea ejecutable
    if [ -x "./crear_usuario.sh" ]; then
        ./crear_usuario.sh
    else
        echo "El script 'crear_usuario.sh' no se encuentra o no tiene permisos de ejecución."
    fi
}

# Función para mostrar el contenido de la carpeta personal
show_cp() {
    echo "Contenido de tu carpeta personal:"
    ls ~
}

# Menú principal con el switch case
while true; do
    echo "Selecciona una opción:"
    echo "1) Almacenar el historial en un fichero"
    echo "2) Mostrar el contenido del fichero"
    echo "3) Crear un nuevo usuario"
    echo "4) Mostrar el contenido de tu carpeta personal"
    echo "5) Salir"
    read -p "Opción: " opcion

    case $opcion in
        1)
            save_historial
            ;;
        2)
            show_historial
            ;;
        3)
            create_usuario
            ;;
        4)
            show_cp
            ;;
        5)
            echo "Saliendo..."
            break
            ;;
        *)
            echo "Opción no válida. Por favor, selecciona una opción entre 1 y 5."
            ;;
    esac
done
