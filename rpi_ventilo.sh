#!/bin/bash

#Param seuil de décenchement du ventilateur
seuil_temperature=41 

#Recuperation de la temperature du proc
temperature=`vcgencmd measure_temp`

#On retient que la partie entière de l'information
temperature=${temperature:5:2}

#fichier de valeur de la broche gpio
fichier="/sys/class/gpio/gpio25/value"

#Test de l'existence du fichier
if [ ! -f /sys/class/gpio/gpio25/value ]
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
     echo 0 > /sys/class/gpio/gpio25/value
     echo 25 > /sys/class/gpio/unexport
   fi
else
  # si la température est trop haute on démarre le ventilateur
  # si il n'est pas déjà démarré
  if [ $gpio_value == 0 ]
   then
    echo 25 > /sys/class/gpio/export
    echo out > /sys/class/gpio/gpio25/direction
    echo 1 > /sys/class/gpio/gpio25/value
  fi  
fi



