#!/bin/bash

# 002_adduser.sh
# JP Antinoux - juin 2015

echo " :: --> Création d'un utilisateur simple"
echo " :: >----------------------------------<"
echo ""
read -p " :: --> Indiquer le nom du nouvel utilisteur : " nom
echo " :: >---------------------------------------------"
echo ""
adduser $nom
		if [ $? = 0 ]
		then
		passwd $nom
      if [ $? = 0 ]
      then
        echo " :: --> Le mot de passe a été défini"
        echo " :: >------------------------------<"
        echo " :: L'utilisateur et son mot de passe ont été créé avec succès !"
        echo " :: >----------------------------------------------------------<"
      else
        echo " :: !!! la création du mot de passe à échoué"
        echo " :: >--------------------------------------<"
        exit 1
     fi 
    else
      echo " :: !!! la création de l'utilisateur à échoué"
      echo " :: >---------------------------------------<"
 	fi

exit 0

