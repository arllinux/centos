#!/bin/bash

# 000_config_git.sh
# JP Antinoux - mai 2015

CWD=$(pwd)

if [ $USER != "root" ] ;
    then
	echo "Pour exécuter ce script il faut être l'utilisateur root !"
else

  # Pour colorer les commandes de git
    bash -c 'git config --global --add color.ui true'
    if [ $? = 0 ]; then
      echo " --> OK La coloration de git est paramétrée"
      echo " >----------------------------------------<"
    else
      echo " !!! Configuration de la couleur non réussie..."
      echo " >--------------------------------------------<"
    fi

  # Pour supprimer le long message lors de l'export de données
    bash -c 'git config --global push.default matching'
    if [ $? = 0 ]; then
      echo " --> OK Le message de confirmation de git a été supprimé"
      echo " >-----------------------------------------------------<"
    else
      echo " !!! Erreur lors de la suppression du message de configuration"
      echo " >-----------------------------------------------------------<"
    fi
    
fi

exit 0
