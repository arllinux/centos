#!/bin/bash
# Made by	db0
# Contact	db0company[at]gmail[dot]com
# Website	http://db0.fr/ 

echo ":: La procédure est en cours de traitement, veuillez patienter 10 secondes"
i=0
while [ $i -le 10 ]
do
    printf "\r%d" $i
    sleep 1
    i=$(($i+1))
done

echo ""

