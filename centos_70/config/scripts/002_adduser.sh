#!/bin/bash

# 002_adduser.sh
# JP Antinoux - juin 2015

echo " :: --> Création d'un utilisateur simple"
echo " :: >------------------------------------<"
echo ""
read -p " :: --> Indiquer le nom du nouvel utilisteur : " nom
echo " :: >---------------------------------------------"
echo ""
adduser $nom
		if [ $? = 0 ]
		then
		passwd $nom
		fi
echo " :: L'utilisateur et son mot de passe ont été créé avec succès !"
echo " :: >----------------------------------------------------------<

exit 0

