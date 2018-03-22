#!/bin/bash

#Param seuil de décenchement du ventilateur
seuil_temperature=41 

temperature=`vcgencmd measure_temperature`

temperature=${temperature:5:2}

fichier="/sys/class/gpio/gpio25/value"

if [ ! -f /sys/class/gpio/gpio25/value ]
then
  gpio_value=0
else
  gpio_value=1
fi
echo $gpio_value

if [ $temperature -lt $seuil_temperature ]
then  
   if [ $gpio_value == 1 ]
   then
     echo 0 > /sys/class/gpio/gpio25/value
     echo 25 > /sys/class/gpio/unexport
   fi
else
  if [ $gpio_value == 0 ]
   then
    echo 25 > /sys/class/gpio/export
    echo out > /sys/class/gpio/gpio25/direction
    echo 1 > /sys/class/gpio/gpio25/value
  fi  
fi



