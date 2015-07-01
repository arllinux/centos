#!/bin/bash

# 009_param_logwatch.sh
# JP Antinoux - janvier 2015

CWD=$(pwd)
WAY='/usr/share/logwatch/default.conf/'

if [ $USER != "root" ] ;
    then
	echo "Pour exécuter ce script il faut être l'utilisateur root !"
else

    # Configuration de logwatch
        echo "--------------------------------"
        echo ":: Configuration de logwatch. ::"
        echo "--------------------------------"
	      cp $WAY/logwatch.conf $WAY/logwatch.conf_old 
				cat $CWD/../logwatch/logwatch.conf > $WAY/logwatch.conf

        echo "----------------------------------"
        echo ":: Modification des paramètres. ::"
        echo "----------------------------------"
        echo ":: --> s'ouvrir pour permettre les modifications"
        $CWD/pause_script.sh
        vim $WAY/logwatch.conf

        echo "------------------------------"
        echo ":: Modifications terminées. ::"
        echo "------------------------------"
fi

exit 0
