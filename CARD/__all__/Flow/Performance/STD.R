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
CARD$P.variable_en = "STD"
CARD$P.unit_en = "m^{3}.s^{-1}"
CARD$P.name_en = "Standard deviation of daily data"
CARD$P.description_en = "This score measures the ability of models to reproduce the variability of the examined variable"
CARD$P.method_en = "1. no temporal aggregation - standard deviation"
CARD$P.topic_en = "Flow, Performance"

### French ___________________________________________________________
CARD$P.variable_fr = "STD"
CARD$P.unit_fr = "m^{3}.s^{-1}"
CARD$P.name_fr = "Écart-type des données journalières"
CARD$P.description_fr = "Ce score mesure la capacité des modèles à reproduire la variabilité de la variable examinée"
CARD$P.method_fr = "1. aucune agrégation temporelle - écart-type"
CARD$P.topic_fr = "Débit, Performance"

### Global ___________________________________________________________
CARD$P.is_date = FALSE
CARD$P.to_normalise = TRUE
CARD$P.palette = NULL


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(STD=compute_STD)
CARD$P1.funct_args = list("Q_obs", "Q_sim", na.rm=TRUE)
CARD$P1.time_step = "none"
CARD$P1.NAyear_lim = 10

