#!/bin/bash

#AndresTenlladoPerez
create_user() {
    echo "Ingrese el nombre de usuario a crear: "
    read usuario
    echo "Ingrese la contraseña para el usuario $usuario: "
    read -s contrasena
    sudo useradd -m $usuario
    echo "$usuario:$contrasena" | sudo chpasswd
    echo "Usuario $usuario creado con éxito."
}

edit_pass() {
    echo "Ingrese el nombre del usuario cuya contraseña desea modificar: "
    read usuario
    sudo passwd $usuario
    echo "Contraseña de $usuario modificada con éxito."
}

delete_user() {
    echo "Ingrese el nombre del usuario a borrar: "
    read usuario
    sudo userdel -r $usuario
    echo "Usuario $usuario eliminado con éxito."
}

show_info() {
    echo "Ingrese el nombre del usuario para mostrar su información: "
    read usuario
    finger $usuario
}

add_group() {
    echo "Ingrese el nombre del usuario a añadir a un grupo: "
    read usuario
    echo "Ingrese el nombre del grupo: "
    read grupo
    sudo usermod -aG $grupo $usuario
    echo "Usuario $usuario añadido al grupo $grupo."
}
#Menu
while true; do
    echo "Seleccione una opción:"
    echo "1. Crear usuario"
    echo "2. Modificar la contraseña de un usuario"
    echo "3. Borrar un usuario"
    echo "4. Mostrar información de un usuario"
    echo "5. Añadir un usuario a un grupo"
    echo "6. Salir"
    read opcion

    case $opcion in
        1) create_user ;;
        2) edit_pass ;;
        3) delete_user ;;
        4) show_info;;
        5) add_group ;;
        6) echo "Saliendo..."; break ;;
        *) echo "Opción no válida, intente de nuevo." ;;
    esac
done
