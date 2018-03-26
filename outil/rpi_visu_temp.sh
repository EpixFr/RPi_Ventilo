#!/usr/bin/bash

#Recuperation de la temperature du proc
temperature=`vcgencmd measure_temp`

#On retient que la partie numérique de l'information
temperature=${temperature:5:4}

echo "Température : "$temperature"°C"
