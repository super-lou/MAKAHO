              _          _
 _ __   __ _ | |__ __ _ | |_   ___
| '  \ / _` || / // _` || ' \ / _ \
|_|_|_|\__,_||_\_\\__,_||_||_|\___/
Généré le [DATE] par MAKAHO.


INFORMATIONS GENERALES _______________________________________________
Titre du jeu de données : Analyse de tendance hydrologique RRSE MAKAHO
DOI : https://doi.org/10.57745/LNBEGZ
site web : https://makaho.sk8.inrae.fr/
code source : https://archive.softwareheritage.org/swh:1:dir:5a8041b9883469f2dd8f32f217ce4b01c37ae992

Adresse de contact :
- contact.makaho@listes.inrae.fr


INFORMATIONS METHODOLOGIQUES _________________________________________
Sources des données : HydroPortail https://www.hydro.eaufrance.fr/
Méthodes utilisées pour collecter les données : HydroPortail https://www.hydro.eaufrance.fr/

Méthodes de traitement des données :
- R Version : 4.x.x
- utilisation du package EXstat https://github.com/super-lou/EXstat
pour l'agrégation et l'analyse de tendance en lien avec le
regroupement de code CARD https://github.com/super-lou/CARD
- traitement réalisable sur MAKAHO https://makaho.sk8.inrae.fr/

Autres information sur les données :
La sélection de station correspond à la celle du Réseau de Référence
pour la Surveillance des Étiages établi dans le papier suivant
https://hal.science/hal-00833431
Ces stations montrent une haute qualité de mesure, des séries
chronologiques avec une profondeur historique de plus de 40 ans,
et leur débit est faiblement impacté par les activités humaines.


APERCUS DES DONNEES ET FICHIERS ______________________________________
- data.csv
Chroniques de débits journalières du RRSE issues des stations de
mesures hydrométriques disponibles sur l'HydroPortail.
Ce fichier n'est pas présent car trop lourd et redondant.
Vous pouvez le télécharger ici avec l'ensemble des
stations disponible : https://doi.org/10.57745/1BBH2Y

- meta.csv
Métadonnées des stations de mesures hydrométriques du RRSE
disponibles sur l'HydroPortail.

- metaEX.csv
Métadonnées des variables extraites.

- dataEX.csv
Données aggrégées selon l'analyse demandée.

- trendEX.csv
Données de l'anlayse de tendance des données aggrégées.

Arborescence :
./
├── data.csv
├── dataEX.csv
├── ETALAB-Licence-Ouverte-v2.0.pdf
├── meta.csv
├── metaEX.csv
├── README
└── trendEX.csv


PARAMÈTRES D'ANALYSE _________________________________________________
[PARAM]


INFORMATIONS SPECIFIQUES AUX DONNEES POUR : *.csv ____________________
- séparateur décimal : .
- Format de date : YYYY-MM-DD
- Code des valeurs manquantes : NA


INFORMATIONS SPECIFIQUES AUX DONNEES POUR : data.csv _________________
- date
  -- nom : date
  -- description : date de la série de données
  -- unité : jour
  -- valeurs autorisées : caractère

- code
  -- nom : code
  -- description : code de la station hydrométrique
  -- valeurs autorisées : caractère

- Q
  -- nom : débit
  -- description : débit journalier mesuré
  -- unité : m3.s-1
  -- valeurs autorisées : numérique


INFORMATIONS SPECIFIQUES AUX DONNEES POUR : meta.csv _________________
- code
  -- nom : code
  -- description : code de la station hydrométrique
  -- valeurs autorisées : caractère

- name
  -- nom : nom
  -- description : nom de la station hydrométrique
  -- valeurs autorisées : caractère

- territoire
  -- nom : territoire
  -- description : territoire contenant la station hydrométrique
  -- valeurs autorisées : caractère

- gestionnaire
  -- nom : gestionnaire
  -- description : gestionnaire de la station hydrométrique
  -- valeurs autorisées : caractère

- XL93_m
  -- nom : X lambert 93
  -- description : position X de la station en lambert 93
  -- unité : m
  -- valeurs autorisées : numérique

- YL93_m
  -- nom : Y lambert 93
  -- description : position Y de la station en lambert 93
  -- unité : m
  -- valeurs autorisées : numérique

- surface_km2
  -- nom : surface
  -- description : surface du bassin versant couvert par la station
  -- unité : km2
  -- valeurs autorisées : numérique

- altitude_m
  -- nom : altitude
  -- description : altitude de la station
  -- unité : m
  -- valeurs autorisées : numérique

- debut
  -- nom : début
  -- description : début de chronique de mesure
  -- valeurs autorisées : caractère

- fin
  -- nom : fin
  -- description : fin de chronique de mesure
  -- valeurs autorisées : caractère

statut
  -- nom : statut
  -- description : statut de la station
  -- valeurs autorisées : [0] inconnu,
     	      		   [1] station avec signification hydrologique,
			   [2] station sans signification hydrologique,
			   [3] station d'essai

finalite
  -- nom : finalité
  -- description : objectif de la station
  -- varleurs autorisées : [0] inconnue,
     	      		   [1] hydrométrie générale,
			   [2] alerte de crue,
			   [3] 1 et 2,
			   [4] gestion d'ouvrage,
			   [5] police des eaux,
			   [6] suivi d'étiage,
			   [7] bassin expérimental,
			   [8] drainage

type
  -- nom : type
  -- description : type de la mesure
  -- varleurs autorisées : [0] inconnu,
     	      		   [1] une échelle,
			   [2] deux échelles, station mère,
			   [3] deux échelles, station fille,
			   [4] débits mesurés,
			   [5] virtuelle
influence
  -- nom : influence
  -- description : influence de la station
  -- varleurs autorisées : [0] inconnue,
     	      		   [1] nulle ou faible,
			   [2] en étiage seulement,
			   [3] forte en toute saison

debit
  -- nom : débit
  -- description : type de débit à la station
  -- varleurs autorisées : [0] reconstitué,
     	      		   [1] réel (prise en compte de l'eau rajoutée ou retirée du bassin selon aménagements),
			   [2] naturel

QBE, QME, QHE
  -- nom : qualité des débits
  -- description : qualité des débit en basses, moyennes, hautes eaux
  -- varleurs autorisées : [0] inconnue,
     	      		   [1] bonne,
			   [2] douteuse

hydrological_region
  -- nom : région hydrologique
  -- description : région hydrologique de la station
  -- valeurs autorisées : caractère


INFORMATIONS SPECIFIQUES AUX DONNEES POUR : metaEX.csv _______________
variable_en
  -- nom : variable
  -- description : acronyme de la variable en anglais
  -- valeurs autorisées : caractère

unit_en
  -- nom : unit
  -- description : unité de la variable en anglais
  -- valeurs autorisées : caractère

name_en
  -- nom : name
  -- description : nom de la variable en anglais
  -- valeurs autorisées : caractère

description_en
  -- nom : description
  -- description : description de la variable en anglais
  -- valeurs autorisées : caractère

method_en
  -- nom : method
  -- description : méthode de calcul de la variable en anglais
  -- valeurs autorisées : caractère

sampling_period_en
  -- nom : sampling period
  -- description : période d'échantillonnage de l'année hydrologique en anglais
  -- valeurs autorisées : caractère

topic_en
  -- nom : topic
  -- description : mot clé concerant la variable en anglais
  -- valeurs autorisées : caractère

** l'ensemble des paramètres ci-dessus sont dérivés en français **

is_date
  -- nom : is date
  -- description : est ce que la variable est associée à un jour de l'année
  -- valeurs autorisées : booléen

to_normalise
  -- nom : to normalise
  -- description : est ce que la variable doit être normalisée
  -- valeurs autorisées : booléen

palette
  -- nom : palette
  -- description : palette de couleur à utiliser pour la variable
  -- valeurs autorisées : caractère
  -- particularité : couleurs séparées par des " "


INFORMATIONS SPECIFIQUES AUX DONNEES POUR : dataEX.csv _______________
- code
  -- nom : code
  -- description : code de la station hydrométrique
  -- valeurs autorisées : caractère

- date
  -- nom : date
  -- description : date de la série de données
  -- unité : année
  -- valeurs autorisées : caractère

- *variable*
  -- nom : *variable*
  -- description : acronyme de la variable disponible dans metaEX.csv avec variable_en
  -- unité : unité de la variable disponible dans metaEX.csv avec unit_en
  -- valeurs autorisées : numérique


INFORMATIONS SPECIFIQUES AUX DONNEES POUR : trendEX.csv ______________
- code
  -- nom : code
  -- description : code de la station hydrométrique
  -- valeurs autorisées : caractère

- variable_en
  -- nom : variable
  -- description : acronyme de la variable en anglais
  -- valeurs autorisées : caractère

- level
  -- nom : level
  -- description : niveau de risque du test de Mann-Kendall
  -- unité : sans unité
  -- valeurs autorisées : numérique entre 0 et 1

- H
  -- nom : H
  -- description : hypothèse du test de Mann-Kendall.
     		   TRUE une tendance est détéctéee.
     		   FALSE aucune tendance n'est détectée.
  -- valeurs autorisées : booléen

- p
  -- nom : p
  -- description : p-value du test de Mann-Kendall
  -- unité : sans unité
  -- valeurs autorisées : numérique

- a
  -- nom : a
  -- description : pente de l'estimateur de Sen-Theil
  -- unité : unité de la *variable* en .an-1
  -- valeurs autorisées : numérique

- b
  -- nom : b
  -- description : ordonnée à l'origine de la droite portée par la
     		   pente de l'estimateur de Sen-Theil
  -- unité : unité de la *variable*
  -- valeurs autorisées : numérique

period_trend
  -- nom : period trend
  -- description : période de l'analyse de tendance
  -- valeurs autorisées : caractère
  -- particularité : date séparées par des " "

- mean_period_trend
  -- nom : mean period trend
  -- description : moyenne de la *variable* sur la période d'analyse
     		   si la *variable* est à normaliser
  -- unité : unité de la *variable*
  -- valeurs autorisées : numérique

- a_normalise
  -- nom : a normalise
  -- description : pente de l'estimateur de Sen-Theil normalisé
  -- unité : % si normalisé sinon en unité de la *variable*
  -- valeurs autorisées : numérique


- a_normalise_min
  -- nom : a normalise min
  -- description : minimum des pentes de l'estimateur de Sen-Theil normalisé
  -- unité : % si normalisé sinon en unité de la *variable*
  -- valeurs autorisées : numérique

- a_normalise_max
  -- nom : a normalise max
  -- description : maximum des pentes de l'estimateur de Sen-Theil normalisé
  -- unité : % si normalisé sinon en unité de la *variable*
  -- valeurs autorisées : numérique
