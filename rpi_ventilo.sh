#!/usr/bin/bash
#######################################################################
#
# RPi Ventilo - By EpxiFr
#
# Gestion d'un ventilateur sur Raspberry Pi en distribution LibreElec
#
# v1.0 - Avril 2018
#
#######################################################################

########################   Paramètres   ###############################

#Param seuil de décenchement du ventilateur
seuil_temperature=55

#Broche Gpio
broche=25

#Mode log (ok/ko)
mode_log="ok"

#Dossier des logs
path_log=$(dirname $0)"/log"

#######################################################################

########################   Programme   ################################

#Recuperation de la temperature du proc
temperature=$(vcgencmd measure_temp)

#On retient que la partie entière de l'information
temperature=${temperature:5:2}

#fichier de valeur de la broche gpio
fichier="/sys/class/gpio/gpio"$broche"/value"

#Test de l'existence du fichier
if [ ! -f $fichier ]
then
  gpio_value=0
else
  gpio_value=1
fi


#Comparaison de la température avec le seuil paramétré
if [ $temperature -lt $seuil_temperature ]
then  
   # si la température est faible on arrête le ventilateur
   # si il est déjà demarré
   if [ $gpio_value == 1 ]
   then
     echo 0 > /sys/class/gpio/gpio$broche/value
     echo 25 > /sys/class/gpio/unexport
   fi
else
  # si la température est trop haute on démarre le ventilateur
  # si il n'est pas déjà démarré
  if [ $gpio_value == 0 ]
   then
    echo 25 > /sys/class/gpio/export
    echo out > /sys/class/gpio/gpio$broche/direction
    echo 1 > /sys/class/gpio/gpio$broche/value
  fi  
fi

#Ecriture du log
if [ $mode_log == "ok" ]
then
  date_log=$(date '+%D %X')

  #Test de l'existence du fichier
  if [ ! -f $fichier ]
  then
    etat_ventilo=0
  else
    etat_ventilo=1
  fi

  echo $date_log" | Temp : "$temperature" | Ventilo : "$etat_ventilo >> $path_log"/rpi_ventilo.log"
fi




