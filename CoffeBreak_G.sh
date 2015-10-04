#!/bin/sh

zenity --info --text "Bienvenidos al asistente de optimizacion para su sistema."
PASSWORD=$(zenity --password)
echo $PASSWORD | sudo -S "command"

echo $PASSWORD | sudo -S "command"

# clear the screen
clear


{
wd=$(pwd)
basename "$(test -L "$0" && readlink "$0" || echo "$0")" > /tmp/scriptname
scriptname=$(echo -e -n $wd/ && cat /tmp/scriptname)
su -c "cp $scriptname /usr/bin/CoffeeBreak" root && echo "Felicitaciones! El programa ha sido instado, ahora puedes usarlo con el comando CoffeeBreak" || echo "Installation failed"
}

zenity --info --text "Ve por una taza de cafe y relajate. SRKDOS"


# Actualizamos lista de repositorios
echo "------------------------------------" 
echo "| Actualizar lista de repositorios | "
echo "| equo update | " 
echo "------------------------------------ "
equo update

# actualizar Entropy 
echo "--------------------------------------------"
echo "| actualizar Entropy | "
echo "| equo install entropy rigo equo --relaxed | "
echo "-------------------------------------------- "
#equo install entropy rigo equo --relaxed

#actualizar los archivos de configuración
echo "------------------------------------------"
echo "| actualizando archivos de configuración |"
echo "| equo conf update | "
echo "------------------------------------------ "
#equo conf update
#depclean && revdep-rebuild && distpatch-conf
#actualizar lista
echo "--------------------------------------"
echo "| actualizando lista de repositorios |"
echo "| equo update | "
echo "-------------------------------------- "
zenity --progress --text "Tenga paciencia ......" --pulsate

equo update

#Actualizar repositorios ordenando los mirros del más rápido al más lento:
echo "--------------------------------------"
echo "| ordenando repositorios mas rápidos |"
echo "| equo repo mirrorsort sabayon-weekly | "
echo "--------------------------------------- "
#equo repo mirrorsort sabayon-weekly

#actualizando el sistema
echo "----------------------------"
echo "| actualizando el sistema | "
echo "| equo upgrade --ask | "
echo "---------------------------- "
#equo upgrade --ask

#Actualizar archivos de configuración, después de actualización.
echo "---------------------------------------------"
echo "| Re-actualizando archivos de configuración |"
echo "| equo conf update | "
echo "--------------------------------------------- "
#equo conf update

#comprobar las dependencias:
echo "---------------------------------"
echo "| comprobando las dependencias |"
echo "| equo deptest | "
echo "---------------------------------- "
#equo deptest

#comprobar las librerías:
echo "-------------------------"
echo "| comprobando librerías |"
echo "| equo libtest          |"
echo "------------------------ "
#equo libtest

#Limpiar archivos rotos y basura. Una vez instalados los paquetes descargados pueden ser removidos
echo "---------------------------------"
echo "|Eliminar paquetes innecesarios.|"
echo "| Equo cleanup                  |"
echo "---------------------------------"
zenity --progress --text "Tenga paciencia falta poco!!  ......" --pulsate

Equo cleanup #este no lo reconoce

echo "------------------"
echo "| Terminado       "
echo "| de actualizar   "
echo "------------------"

echo  $USER "Hasta pronto"

zenity --progress --text "Por favor tenga paciencia ......" --pulsate



# use 'color --list'

################################################################
#
# Host logo
#
################################################################

echo -ne "$(color ltblack black)"
cat << 'EOF'

echo"  ___         __   __          ___                    _    
echo "   / __\ ___   / _| / _|  ___   / __\ _ __  ___   __ _ | | __
echo "  / /   / _ \ | |_ | |_  / _ \ /__\//| '__|/ _ \ / _` || |/ /
echo " / /___| (_) ||  _||  _||  __// \/  \| |  |  __/| (_| ||   <" 
echo  "\____/ \___/ |_|  |_|   \___|\_____/|_|   \___| \__,_||_|\_\"
echo" 

cat << 'EOF'

################################################################
#
# Local information
#
################################################################


#PASSWORD=$(zenity --password)
#echo $PASSWORD | sudo -S "command"
#echo $PASSWORD | sudo -S "command"
#exit

#!/bin/bash

setup_lang() {
    export LANG=es_ES
    export LANGUAGE=${LANG}
    export LC_ALL=${LANG}.UTF-8

    echo "es_ES.UTF-8 UTF-8" >> /etc/locale.gen
    locale-gen
}
#agregaremos nuestra zona horaria 
setup_system() {
    ln -sf ../usr/share/zoneinfo/America/Caracas /etc/localtime
    #agregaremos lod DNS de google al archivho resolv.conf
    echo "nameserver 8.8.8.8" > /etc/resolv.conf
    echo -n '\n' >> "nameserver 8.8.4.4"
    echo $/etc/resolv.conf
    sleep 
    # colocaremos a python 2.7 por defecto
    eselect python set 1
    env-update
    source /etc/profile
}

prepare_portage() {

    #emerge --sync
    echo "Actualizaremos portage."
    TMOUT=5 
    echo 'MAKEOPTS="-j5"' >> /etc/portage/make.conf 
    
    mkdir -p /etc/portage/package.keywords
    mkdir -p /etc/portage/package.use

    echo "sys-apps/entropy ~amd64" >> /etc/portage/package.keywords/entropy
    echo "app-admin/equo ~amd64" >> /etc/portage/package.keywords/entropy
    
    echo"-----agregaremos layman, para nuevos paquetes!
    echo------ esta usted de acuerdo?"
    **************************voy por aca************************
    echo "app-portage/layman git"  > /etc/portage/package.use/layman

sleep 10s
    
    env-update
    source /etc/profile
}
sleep 10s

install_layman() {
    emerge -v layman
    layman -a sabayon
    layman -S

    echo "source /var/lib/layman/make.conf" >> /etc/portage/make.conf
    env-update
    source /etc/profile
}
sleep 10s

install_entropy() {
    emerge -vt app-admin/equo sys-apps/entropy --autounmask-write
    etc-update --automode -5
    emerge -vt app-admin/equo sys-apps/entropy
}
sleep 10s

setup_lang
setup_system
prepare_portage
install_layman
install_entropy

TMOUT=5

echo "--------------------------"
echo "| Desea usted             "
echo "| Compilar algun codigo   "
echo "--------------------------"

if [[ -z $var ]]
then
    read -p "No hay algun codigo para contruir, desea continuar(Y/N)? " choice
    if [[ $choice == "N"  ||  $choice == "n" ]]
    then
        exit 0
    fi
fi
