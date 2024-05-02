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
CARD$P.variable_en = "medQJC5"
CARD$P.unit_en = "m^{3}.s^{-1}"
CARD$P.name_en = "5-day centered moving average of the inter-annual median flow"
CARD$P.description_en = ""
CARD$P.method_en = "1. aggregation by day of the year - median
2. no temporal aggregation - 5-day centered moving average"
CARD$P.topic_en = "Flow, Mean Flows, Intensity"

### French ___________________________________________________________
CARD$P.variable_fr = "medQJC5"
CARD$P.unit_fr = "m^{3}.s^{-1}"
CARD$P.name_fr = "Moyenne mobile sur 5 jours du débit médian inter-annuel"
CARD$P.description_fr = ""
CARD$P.method_fr = "1. agrégation par jour de l’année - médiane
2. aucune agrégation temporelle - moyenne mobile centrée sur 5 jours"
CARD$P.topic_fr = "Débit, Moyennes Eaux, Intensité"

### Global ___________________________________________________________
CARD$P.is_date = FALSE
CARD$P.to_normalise = TRUE
CARD$P.palette = NULL


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list("medQJ"=median)
CARD$P1.funct_args = list("Q", na.rm=TRUE)
CARD$P1.time_step = "yearday"
CARD$P1.NApct_lim = NULL
CARD$P1.NAyear_lim = NULL

### P2 _______________________________________________________________
CARD$P2.funct = list("medQJC5"=rollmean_center)
CARD$P2.funct_args = list("medQJ", k=5, isCyclical=TRUE)
CARD$P2.time_step = "none"
CARD$P2.keep = "all"

