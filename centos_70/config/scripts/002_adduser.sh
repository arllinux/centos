#!/bin/bash

echo " :: Création d'un utilisateur simple"
read -p " :: Indiquer le nom du nouvel utilisteur :" nom
adduser $nom
		if [ $? = O ]
		then
		passwd $nom
		fi
echo " :: L'utilisateur et son mot de passe ont été créé avec succès !"

exit 0
