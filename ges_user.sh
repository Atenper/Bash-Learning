#!/bin/bash

# AndresTenlladoPerez
crear_usuario() {
    echo "Introduce el nombre de usuario:"
    read usuario
    echo "Introduce la contraseña del usuario:"
    read -s contrasena

    sudo useradd "$usuario"
    echo "$usuario:$contrasena" | sudo chpasswd
    echo "Usuario $usuario creado correctamente."
}

modificar_contrasena() {
    echo "Introduce el nombre del usuario para cambiar su contraseña:"
    read usuario
    echo "Introduce la nueva contraseña:"
    read -s contrasena

    echo "$usuario:$contrasena" | sudo chpasswd
    echo "Contraseña de $usuario modificada correctamente."
}

borrar_usuario() {
    echo "Introduce el nombre del usuario a borrar:"
    read usuario
    sudo userdel -r "$usuario"
    echo "Usuario $usuario borrado correctamente."
}

dar_de_alta_usuarios() {
    echo "Introduce la ruta del fichero con los usuarios (nombre,DNI,password):"
    read archivo

    if [ ! -f "$archivo" ]; then
        echo "El fichero no existe."
        return
    fi

    while IFS=, read -r nombre dni password; do
        sudo useradd "$nombre" && echo "$nombre:$password" | sudo chpasswd
        echo "Usuario $nombre con DNI $dni dado de alta correctamente."
    done < "$archivo"
}

# Función principal que muestra el menú
mostrar_menu() {
    clear
    echo "Menú de Gestión de Usuarios"
    echo "1. Crear usuario"
    echo "2. Modificar contraseña de usuario"
    echo "3. Borrar usuario"
    echo "4. Dar de alta usuarios desde un fichero"
    echo "5. Salir"
    echo "Introduce una opción (1-5):"
    read opcion

    case $opcion in
        1)
            crear_usuario
            ;;
        2)
            modificar_contrasena
            ;;
        3)
            borrar_usuario
            ;;
        4)
            dar_de_alta_usuarios
            ;;
        5)
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

