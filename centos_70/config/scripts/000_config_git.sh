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
      echo "La coloration de git est paramétrée"
    else
      echo "Configuration de la couleur non réussie..."
    fi

  # Pour supprimer le long message lors de l'export de données
    bash -c 'git config --global push.default matching'
    if [ $? = 0 ]; then
      echo "Le message de confirmation de git a été supprimé"
    else
      echo "Erreur lors de la suppression du message de configuration"
    fi
    
fi

exit 0
