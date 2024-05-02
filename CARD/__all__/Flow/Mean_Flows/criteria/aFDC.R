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
CARD$P.variable_en = "aFDC"
CARD$P.unit_en = "without unit"
CARD$P.name_en = "Slope of the segment between the 33% and 66% quantiles of the flow duration curve"
CARD$P.description_en = ""
CARD$P.method_en = "1. no temporal aggregation - computation of the flow duration curve and differences between quantiles"
CARD$P.topic_en = "Flow, Mean Flows, Intensity"

### French ___________________________________________________________
CARD$P.variable_fr = "aCDC"
CARD$P.unit_fr = "sans unité"
CARD$P.name_fr = "Pente du segment entre les quantiles des débits journaliers à 33 % et 66 % de la courbe des débits classés"
CARD$P.description_fr = ""
CARD$P.method_fr = "1. aucune agrégation temporelle - calcul de la courbe des débits classés et des différences entre quantiles"
CARD$P.topic_fr = "Débit, Moyennes Eaux, Intensité"

### Global ___________________________________________________________
CARD$P.is_date = FALSE
CARD$P.to_normalise = TRUE
CARD$P.palette = NULL


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(aFDC=fdc_slope)
CARD$P1.funct_args = list("Q", p=c(0.33, 0.66))
CARD$P1.time_step = "none"
CARD$P1.NAyear_lim = 10

