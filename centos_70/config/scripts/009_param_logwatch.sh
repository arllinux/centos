#!/bin/bash

# 009_param_logwatch.sh
# JP Antinoux - janvier 2015

CWD=$(pwd)

if [ $USER != "root" ] ;
    then
	echo "Pour exécuter ce script il faut être l'utilisateur root !"
else

    # Configuration de logwatch
        echo "--------------------------------"
        echo ":: Configuration de logwatch. ::"
        echo "--------------------------------"
	      cat $CWD/../logwatch/logwatch.conf > /etc/logwatch/logwatch.conf

        echo "----------------------------------"
        echo ":: Modification des paramètres. ::"
        echo "----------------------------------"
				echo ":: le fichier de configuration de logwatch va s'ouvrir pour
  			permettre les modifications"
  			bash -c chrono.sh
        vim /etc/logwatch/logwatch.conf

        echo "------------------------------"
        echo ":: Modifications terminées. ::"
        echo "------------------------------"
fi

exit 0
