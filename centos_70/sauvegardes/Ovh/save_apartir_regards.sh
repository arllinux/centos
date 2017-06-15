#!/bin/bash
# 17/06/2017
# JP Antinoux

# save_apartir_regards.sh (dans /root/bin du serveur HP serveur7centos)
# Lancement à 23 h 30
# crontab -l
# 30 23 * * 1-5 /root/bin/save_apartir_regards

# --\\\\\--

#     Machine A désigne le serveur local où se trouve les sauvegardes.
#     Machine B désigne le serveur distant

# 1 - Ce script effectue la rotation des journées en lançant "rotation_10jours.sh"
#     Ce script permet d'archiver les vues les plus anciennes.
#     sur 10 jours ouvrables.

# 2 - Ce script vérifie la présence de la machine B,

# 3 - lancement de rsync.
#
#     Les infos sur les opérations effectuées se trouvent dans le fichier
#     "/root/bin/logs_sauvegardes/logfile_HP_DELL.txt" sur la machine A.
# --\\\\\--

Date=$(date +%d-%m-%Y)
Heure=$(date +%T)
SOURCEDIR='/srv/samba/partage2015/partages/*'
DESTDIR='/mnt/raid3456/sauvegardes_2015/Dossier_partagé_2015'
SERVEUR="utilisateur@37.59.58.161"
logfile='/root/bin/logs_sauvegardes/logfile_HP_DELL.txt'
H='horairejour'
# --\\\\\--

# Le script vérifie si la machine B est connectée.

echo -e "----\nLancement sauvegarde à : $Heure le $Date" >> $logfile
  ping -c 1 37.59.58.161 > /dev/null
if [ $? = "0" ]
  then

  # Si c'est le cas exécute le script "rotation_10jours.sh"
    bash -c "/root/bin/rotation_10jours.sh"
    if [ $? = "0" ]
	   then

	# Si le script précédent s'est bien déroulé,
	# Lance la syncro 
		rsync -av -e "ssh -p 18525" utilisateur@37.59.52.161:/home/utilisateur/archive.tar.bz2 .
	        Date=$(date +%d-%m-%Y)
    		Heure=$(date +%T)

		echo -e "Sauvegarde terminée à  : $Heure le $Date\n" >> $logfile
		echo -e "-------------------------------------------------------"
	  		else
	  echo -e "\n!!!!! Le dossier jour.0 est absent\nSauvegarde interrompue à $Heure le $Date" >> $logfile
	  echo -e "---------------------------------------------------------------"
     fi			
   else
    echo -e "\n!!!!! Serveur inaccessible : échoué à $Heure le $Date" >> $logfile
    echo -e "---------------------------------------------------------------"
fi
exit 0

# --\\\\\--
