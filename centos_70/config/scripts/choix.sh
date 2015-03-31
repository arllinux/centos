#!/bin/bash
PS3="> selectionnez un plat : " # definie l'invite du menu
echo " -- menu du jour -- " # affiche un titre
select choix in cassoulet pizza "salade du chef" "quitter (q|Q)"; do
case $REPLY in
    1) echo "Voici votre $choix."
       echo "Desirez-vous autre chose ?";;
    2) echo "Une pizza ? Excellent choix !"
       echo "Desirez-vous autre chose ?";;
    3) echo "Et une $choix, une !"
       echo "Desirez-vous autre chose ?";;
    4|Q*|q*) echo "Au revoir" # on quitte en appuyant sur 4, ou en tapant un mot commancant par Q ou q
       break;;
    *) echo "Je n'ai pas compris votre commande. Veuillez repeter svp.";;
esac
done

