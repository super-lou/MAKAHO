#   ___                _ 
#  / __| __ _  _ _  __| |
# | (__ / _` || '_|/ _` |
#  \___|\__,_||_|  \__,_|
# Copyright 2022-2024 Louis Héraut (louis.heraut@inrae.fr)*1
#
# *1   INRAE, France
#
# This file is part of CARD R library.
#
# CARD R library is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# CARD R library is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with CARD R library.
# If not, see <https://www.gnu.org/licenses/>.


## INFO ______________________________________________________________
### English __________________________________________________________
CARD$P.variable_en = "KGE"
CARD$P.unit_en = "without unit"
CARD$P.name_en = "Kling-Gupta Performance Coefficient"
CARD$P.description_en = "It measures the proximity between reference and simulated data series based on three sub-criteria (r, alpha, and beta) with equal weights. The coefficient gives strong weight to the reconstruction of high values of the examined variable."
CARD$P.method_en = "1. no temporal aggregation - calculation of KGE."
CARD$P.topic_en = "Flow, Performance"

### French ___________________________________________________________
CARD$P.variable_fr = "KGE"
CARD$P.unit_fr = "sans unité"
CARD$P.name_fr = "Coefficient de performance de Kling-Gupta"
CARD$P.description_fr = "Il mesure la proximité entre les séries de données de référence et celles simulées, sur la base de trois sous-critères (r, alpha et beta) aux pondérations identiques. Le coefficient donne un poids fort à la reconstitution des valeurs fortes de la variable examinée."
CARD$P.method_fr = "1. aucune agrégation temporelle - calcul du KGE"
CARD$P.topic_fr = "Débit, Performance"

### Global ___________________________________________________________
CARD$P.source = "GUPTA, H. V. et al. (2009). « Decomposition of the mean squared error and NSE performance criteria : Implications for improving hydrological modelling ». In : Journal of Hydrology 377, p. 80-91."
CARD$P.is_date = FALSE
CARD$P.to_normalise = FALSE
CARD$P.palette = NULL


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(KGE=compute_KGE)
CARD$P1.funct_args = list("Q_obs", "Q_sim")
CARD$P1.time_step = "none"
CARD$P1.NAyear_lim = 10

