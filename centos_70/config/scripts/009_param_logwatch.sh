#!/bin/bash

# 009_param_logwatch.sh
# JP Antinoux - janvier 2015

CWD=$(pwd)

[ $USER != "root" ] ;
if [ $? = "0" ]
    then
	echo "Pour exécuter ce script il faut être l'utilisateur root !"
else

    # Configuration de logwatch
        echo "--------------------------------"
        echo ":: Configuration de logwatch. ::"
        echo "--------------------------------"
	      cat $CWD/../logwatch/logwatch.conf > /etc/logwatch/logwatch.conf
	      chown root:root /etc/logwatch/logwatch.conf
	      chmod 0644 /etc/logwatch/logwatch.conf

        echo "----------------------------------"
        echo ":: Modification des paramètres. ::"
        echo "----------------------------------"

        vim /etc/logwatch/logwatch.conf

        echo "------------------------------"
        echo ":: Modifications terminées. ::"
        echo "------------------------------"
fi

exit 0
