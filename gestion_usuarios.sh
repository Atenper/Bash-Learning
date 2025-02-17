#!/bin/bash

#AndresTenlladoPerez
alta_manual(){
    echo "Introduce el nombre del nuevo usuario:"
    read usuario
    sudo useradd $usuario
    echo "Introduce la contraseña para el nuevo usuario:"
    echo "$usuario:$contrasena" | sudo chpasswd
}

alta_automatica(){
    echo "Introduce la ruta del fichero con los usuarios (formato: usuario,contraseña,...):"
    read fichero
    while IFS=, read -r usuario contrasena descripcion correo; do
      echo "Creando usuario $usuario con contraseña $contrasena"
      sudo useradd -c "$descripcion, $correo" $usuario
      echo "$usuario:$contrasena" | sudo chpasswd
    done < "$fichero"
}

del_user(){
    echo "Introduce el nombre del usuario a borrar:"
    read usuario
    echo "Introduce la contraseña para confirmar la eliminación del usuario $usuario:"
    read -s contrasena
    if sudo passwd -S $usuario | grep -q 'P'; then
      sudo userdel $usuario
      echo "Usuario $usuario eliminado."
    else
      echo "Contraseña incorrecta."
    fi
}

while true; do
    echo "Seleccione una opción de gestión de usuarios:"
    echo "1. Dar de alta usuario manualmente"
    echo "2. Dar de alta usuarios automáticamente"
    echo "3. Borrar un usuario"
    echo "4. Salir"
    read opcion

    case $opcion in
    1)
        alta_manual
        ;;
    2)
        alta_automatica
        ;;
    3)
        del_user
        ;;
    4)
        echo "Saliendo del script..."
        break
        ;;
    *)
        echo "Opción no válida"
        ;;
    esac
done
