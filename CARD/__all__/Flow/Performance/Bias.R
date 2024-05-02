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
CARD$P.variable_en = "Bias"
CARD$P.unit_en = "without unit"
CARD$P.name_en = "Bias"
CARD$P.description_en = "Relative difference between simulated and reference data. It measures the mean deviation over the entire series."
CARD$P.method_en = "1. no temporal aggregation - Bias calculation"
CARD$P.topic_en = "Flow, Performance"

### French ___________________________________________________________
CARD$P.variable_fr = "Biais"
CARD$P.unit_fr = "sans unité"
CARD$P.name_fr = "Biais"
CARD$P.description_fr = "Différence relative entre les données simulées et de référence. Il mesure l’écart moyen sur l’ensemble de la série."
CARD$P.method_fr = "1. aucune agrégation temporelle - calcul du Biais"
CARD$P.topic_fr = "Débit, Performance"

### Global ___________________________________________________________
CARD$P.is_date = FALSE
CARD$P.to_normalise = FALSE
CARD$P.palette = NULL


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(Bias=compute_Biais)
CARD$P1.funct_args = list("Q_obs", "Q_sim")
CARD$P1.time_step = "none"
CARD$P1.NAyear_lim = 10

