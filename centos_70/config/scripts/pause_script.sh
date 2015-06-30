#!/bin/bash
# pause_script.sh : appuyer sur la touche <Entrée> pour continuer un script

echo " === Appuyer la touche <Entrée> pour continuer... ==="
read touche
case $touche in
*)	echo " =============== Reprise du script... ==============="
	;;
esac
