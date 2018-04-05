RPi Ventilo
===========

RPi Ventilo est un petit script bash permettant de gérer simplement l'activité de fonctionnement d'un ventilateur branché sur le GPIO d'un Raspberry Pi.


Fonctionnement
--------------

 Le script vérifie la température du RPi. Si la limite fixée est dépassée le ventilateur est démarré sinon il est éteint.

 En ajoutant une tâche CRON, le script peut s'exécuter toutes les minutes.


Environnement
-------------

Le script fonctionne sur un RPi 3 avec la distribution LibreElec. Cette distribution laisse peu d'options de mise à jour, et elle ne dispose pas de Git en natif.
L'installation doit donc se réaliser par copie du projet directement sur le RPi.


Installation
------------

Copier les fichiers dans le dossier de votre choix. Dans mon cas, le projet se trouve dans le dossier : 
    \\192.168.0.x\Userdata\RPiVentilo

Accessible en samba si activité sur le RPi (avec LibreElec).

Rendre le script exécutable

    chmod +x rpi_ventilo.sh

Tester le script

    ./rpi_ventilo.sh


Tâche CRON
-----------

Il faut se connecter en SSH sur le RPi. Pour rappel, sur le RPi avec LibreElec le compte d'accès est `root` avec le MdP `libreelec`

    crontab -e

Insérer la ligne suivante

    */1 * * * *  bash /storage/.kodi/userdata/RPiVentilo/rpi_ventilo.sh

Vérifier le fonctionnement de la tâche CRON :

    systemctl status cron -l


Configuration
-------------

Plusieurs paramètres peuvent être modifiés au sein du fichier de script `rpi_ventilo.sh`

### Paramètres

| **Nom** | **Description** | **Valeur par défaut** |
|:--------|:----------------|:----------------------|
| seuil_temperature | valeur de la température maxi avant démarrage du ventilateur exprimé en °C | 55 |
| broche | Numéro de la broche GPIO sur laquelle est branchée le ventilateur (voir cartographie dans le dossier outils) | 25 |
| mode_log | Indication de l'enregistrement des logs. ok si activité | ok |
| path_log | Chemin de destination des logs | $(dirname $0)"/log" |


Crédits
-------

RPi_Ventilo est développé par [Eric Gautheron][1].

[1]: http://eric.gautheron.info




