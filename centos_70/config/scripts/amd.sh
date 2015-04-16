#!/bin/bash

# amd.sh
# JP Antinoux - février 2015

CWD=$(pwd)

if [ $USER != "root" ] ;
    then
	      echo "Pour exécuter ce script il faut être l'utilisateur root !"
  else
      # Correction du bug "Failed to load file microcode_amd.bin"
        echo "-----------------------------------------"
        echo ":: Installation du microcode Amd ::"
        echo "-----------------------------------------"
        cp -r $CWD/../amd-ucode /lib/firmware 
fi
exit 0
